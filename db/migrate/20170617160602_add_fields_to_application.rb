class AddFieldsToApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :application_for_events, :volunteered_before, :boolean, default: false, null: false
    add_column :application_for_events, :been_before, :boolean, default: false, null: false
    add_index :application_for_events, :volunteered_before
    add_index :application_for_events, :been_before
  end
end
