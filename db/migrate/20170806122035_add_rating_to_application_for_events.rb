class AddRatingToApplicationForEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :application_for_events, :rating, :integer, :in => 0..5
  end
end
