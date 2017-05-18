class CreateApplicationForEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :application_for_events, id: :uuid do |t|
      t.belongs_to :event, type: :uuid, index: true
      t.belongs_to :volunteer, type: :uuid, index: true
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
