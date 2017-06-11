class ChangeVolunteerIdToUserIdApplications < ActiveRecord::Migration[5.1]
  def change
    remove_reference :application_for_events, :volunteer, type: :uuid, index: true
    change_table :application_for_events, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, index: true
    end
  end
end
