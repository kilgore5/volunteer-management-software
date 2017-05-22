class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts, id: :uuid do |t|
      t.belongs_to :rotation, type: :uuid, index: true
      t.belongs_to :volunteer, type: :uuid, index: true
      t.integer :length, default: 1
      t.integer :start_time
      t.integer :count

      t.timestamps
    end
  end
end
