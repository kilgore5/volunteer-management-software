class AddInitialChargeFieldsToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :initial_charge_description, :string
    add_column :events, :initial_charge_cents, :integer
  end
end
