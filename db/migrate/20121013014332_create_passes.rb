class CreatePasses < ActiveRecord::Migration
  def change
    create_table :passes do |t|
      # t.string :pass_type_identifier
      t.belongs_to :medication
      t.string :serial_number
      t.string :auth_token

      t.timestamps
    end

    add_index :passes, :serial_number
  end
end
