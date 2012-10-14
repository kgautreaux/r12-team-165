class Medication < ActiveRecord::Base
  has_one :pass, class_name: "Passbook::Pass", inverse_of: :medication
  belongs_to :user

  mount_uploader :thumbnail, MedicationImageUploader

  attr_accessible :active, :category, :directions, :dose, :name, :rationale, :units, :thumbnail

  after_create do |med|
    get_updated_thumbnail(med) unless med.thumbnail.current_path
  end

  after_save do
    self.pass.updated_at = self.updated_at
    self.pass.save!
    send_push_notification(self)
  end

  def get_updated_thumbnail(med)
      result = Pillboxr.with(image: true, ingredient: med.name, api_key: Mconf[Rails.env][:pillboxr_api_key])
      med.remote_thumbnail_url = result.pills.first.image_url unless result.record_count == 0
      med.save!
  end

  def send_push_notification(med)
    push_tokens = med.pass.registrations.map(&:push_token)

    if push_tokens.present?
      pusher = Grocer.pusher(certificate: Mconf[Rails.env][:push_cert_path],
                             passphrase: Mconf[Rails.env][:p12_cert_password],
                             gateway: 'gateway.push.apple.com')
      push_tokens.each do |token|
        notification = Grocer::Notification.new({device_token: token}, true)
        pusher.push(notification)
      end
    end
  end

  handle_asynchronously :get_updated_thumbnail
  handle_asynchronously :send_push_notification
end
