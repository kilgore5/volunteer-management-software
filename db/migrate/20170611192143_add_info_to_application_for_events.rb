class AddInfoToApplicationForEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :application_for_events, :info, :text
  end
end
