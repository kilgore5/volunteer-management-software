class AddDeadlineToDeclineToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :deadline_to_decline, :datetime
    add_column :events, :primary_contact_email, :string
  end
end
