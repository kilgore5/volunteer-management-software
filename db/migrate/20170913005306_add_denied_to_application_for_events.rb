class AddDeniedToApplicationForEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :application_for_events, :denied, :boolean
  end
end
