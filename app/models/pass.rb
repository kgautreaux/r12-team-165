class Pass < ActiveRecord::Base
  has_many :registrations, class_name: "Passbook::Registration"
  belongs_to :medication, class_name: "Medication", inverse_of: :pass

  validates_presence_of :serial_number
  validates_uniqueness_of :serial_number

  attr_accessible :serial_number

  def format_version
    1
  end

  def pass_type_identifier
    "pass.medpass.medication"
  end

  def team_identifier
    "LVRJ4ZVF84"
  end

  def webservice_url
    Mconf[:webservice_url]
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

  def respond_to_missing?(method, include_private = false)
    super
    Mconf.has_key?(method.to_sym)
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
