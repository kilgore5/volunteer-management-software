class AddInvitationAcceptedToApplicationForEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :application_for_events, :invitation_accepted, :boolean
  end
end
