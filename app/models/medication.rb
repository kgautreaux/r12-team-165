class Medication < ActiveRecord::Base
  has_one :pass, class_name: "Passbook::Pass", inverse_of: :medication
  attr_accessible :active, :category, :directions, :dose, :image_name, :image_path, :name, :rationale, :units

  after_save do
    self.pass.updated_at = self.updated_at
    self.pass.save!
  end
end
