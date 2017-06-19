class AddTermsToApplicationForEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :application_for_events, :terms_accepted, :boolean
  end
end
