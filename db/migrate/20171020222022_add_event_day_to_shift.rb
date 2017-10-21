class AddEventDayToShift < ActiveRecord::Migration[5.1]
  def change
    change_table :shifts, id: :uuid do |t|
      t.belongs_to :event_day, type: :uuid, index: true
      t.belongs_to :job, type: :uuid, index: true
    end
    remove_column :shifts, :start_time
    add_column :shifts, :start_time, :datetime
  end
end
