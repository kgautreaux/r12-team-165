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
  end

  def get_updated_thumbnail(med)
      result = Pillboxr.with(image: true, ingredient: med.name, api_key: Mconf[Rails.env][:pillboxr_api_key])
      med.remote_thumbnail_url = result.pills.first.image_url unless result.record_count == 0
      med.save!
  end

  handle_asynchronously :get_updated_thumbnail
end
