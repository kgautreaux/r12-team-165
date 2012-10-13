class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :device_library_identifier
      t.string :push_token
      t.belongs_to :pass

      t.timestamps
    end

    add_index :registrations, :device_library_identifier
  end
end
