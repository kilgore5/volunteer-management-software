class AddStateToApplies < ActiveRecord::Migration[5.1]
  def change
    add_column :applies, :state, :string
  end
end
