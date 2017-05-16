class CreateEventDays < ActiveRecord::Migration[5.1]
  def change
    create_table :event_days, id: :uuid do |t|
      t.references :event, type: :uuid, index: true
      t.date :date

      t.timestamps
    end
  end
end
