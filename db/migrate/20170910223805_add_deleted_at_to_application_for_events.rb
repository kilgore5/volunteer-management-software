class AddDeletedAtToApplicationForEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :application_for_events, :deleted_at, :datetime
    add_index :application_for_events, :deleted_at
  end
end
