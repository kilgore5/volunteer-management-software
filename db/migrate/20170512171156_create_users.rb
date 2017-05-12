class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.date :birthday
      t.string :mobile_number
      t.string :slug
      t.integer :shifts_made, default: 0
      t.integer :shifts_missed, default: 0
      t.integer :apps_accepted, default: 0
      t.integer :hours_worked, default: 0
      t.float :rating

      t.timestamps
    end
    add_index :users, :slug, unique: true
  end
end
