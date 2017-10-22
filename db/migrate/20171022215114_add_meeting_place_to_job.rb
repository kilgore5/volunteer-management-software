class AddMeetingPlaceToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :meeting_place, :string, default: "The Volunteer Tent"
  end
end
