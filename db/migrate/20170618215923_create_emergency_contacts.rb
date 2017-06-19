class CreateEmergencyContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :emergency_contacts, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, index: true
      t.string :name
      t.string :phone_number
      t.string :relationship

      t.timestamps
    end
  end
end
