class Pass < ActiveRecord::Base
  has_many :registrations, class_name: "Passbook::Registration"
  belongs_to :medication, class_name: "Medication", inverse_of: :pass

  validates_presence_of :pass_type_identifier, :serial_number
  validates_uniqueness_of :serial_number, scope: :pass_type_identifier

  attr_accessible :pass_type_identifier, :serial_number

  def respond_to_missing?(method, include_private = false)
    super
    self.medication.respond_to?(method)
  end

  def method_missing(method, *args, &block)
    if self.medication.respond_to?(method.to_sym)
      self.medication.send(method.to_sym, *args, &block)
    else
      super
    end
  end
end
