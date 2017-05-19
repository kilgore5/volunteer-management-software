class CreateRotations < ActiveRecord::Migration[5.1]
  def change
    create_table :rotations, id: :uuid do |t|
      t.belongs_to :shift_manager, type: :uuid, index: true
      t.belongs_to :day, type: :uuid, index: true
      t.belongs_to :job, type: :uuid, index: true
      t.integer :length, default: 1
      t.datetime :start_time
      t.integer :count

      t.timestamps
    end
  end
end
