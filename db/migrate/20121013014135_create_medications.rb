class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.string :name
      t.float :dose
      t.string :units, :null => false, :default => "mg"
      t.string :category, :null => false, :default => "medication"
      t.string :rationale, :null => false, :default => "general health"
      t.boolean :active, :null => false, :default => false
      t.string :directions
      t.string :image_path
      t.string :image_name
      t.belongs_to :patient

      t.timestamps
    end

    add_index :medications, [:active, :category, :units, :name]
  end
end
