class Passbook::Pass < ActiveRecord::Base
  has_many :registrations, class_name: "Passbook::Registration"
  belongs_to :medication, class_name: "Medication", inverse_of: :pass
  delegate :name, :dose, :units, :directions, :category, :rationale, :active, to: :medication

  validates_presence_of :serial_number
  validates_uniqueness_of :serial_number

  attr_accessible :serial_number, :auth_token

  def files
    a = [Mconf[Rails.env][:pass_images_path] + 'icon@2x.png',
     Mconf[Rails.env][:pass_images_path] + 'logo@2x.png',
     Mconf[Rails.env][:pass_images_path] + 'icon.png',
     Mconf[Rails.env][:pass_images_path] + 'logo.png',
     (self.medication.thumbnail.current_path || Mconf[Rails.env][:pass_images_path] + 'thumbnail@2x.png')]

     Rails.logger.info("files returned #{a}.")
     return a
  end

  def take_now?
    active ? "Yes" : "No"
  end

  def format_version
    1
  end

  def pass_type_identifier
    "pass.medpass.medication"
  end

  def team_identifier
    Mconf[:team_identifier]
  end

  def webservice_url
    Mconf[:webservice_url]
  end

  def locations
    [
      {
        longitude: self.medication.user.practice.longitude,
        latitude: self.medication.user.practice.latitude
      }
    ].to_json
  end

  def barcode
    {
      message: description,
      format: "PKBarcodeFormatQR",
      messageEncoding: "iso-8859-1"
    }.to_json
  end

  def organization_name
    "medpasses.es"
  end

  def description
    "Medication: #{self.medication.name.capitalize} #{Integer(self.medication.dose)}#{self.medication.units} daily"
  end

  def logo_text
    "edpass.es"
  end

  def readable_dose
    self.dose
  end

  # def respond_to_missing?(method, include_private = false)
  #   super
  #   self.medication.respond_to?(method)
  # end

  # def method_missing(method, *args, &block)
  #   if self.medication.respond_to?(method.to_sym)
  #     self.medication.send(method.to_sym, *args, &block)
  #   else
  #     super
  #   end
  # end
end
