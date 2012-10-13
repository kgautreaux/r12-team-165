class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.float :latitude
      t.float :longitude
      t.string :fax_number
      t.string :telephone_number
      t.string :address
      t.string :name

      t.timestamps
    end
  end
end
