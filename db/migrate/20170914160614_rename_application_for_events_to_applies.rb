class RenameApplicationForEventsToApplies < ActiveRecord::Migration[5.1]
  def change
    rename_table :application_for_events, :applies
    rename_column :application_preferred_jobs, :application_for_event_id, :apply_id
  end
end
