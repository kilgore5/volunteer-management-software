class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events, id: :uuid do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.float :event_length
      t.integer :ticket_price_cents
      t.references :client_owner, type: :uuid, index: true

      t.timestamps
    end
  end
end
