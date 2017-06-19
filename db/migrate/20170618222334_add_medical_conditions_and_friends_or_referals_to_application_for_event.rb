class AddMedicalConditionsAndFriendsOrReferalsToApplicationForEvent < ActiveRecord::Migration[5.1]
  def change
    change_table :application_for_events, id: :uuid do |t|
      t.text :friends_or_referrals
    end
  end
end
