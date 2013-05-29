class CreatePresentEntries < ActiveRecord::Migration
  def change
    create_table :present_entries do |t|
      t.string :name
      t.string :address
      t.string :mobile_phone_number
      t.string :email

      t.timestamps
    end
  end
end
