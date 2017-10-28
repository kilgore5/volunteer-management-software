class AddStateToShifts < ActiveRecord::Migration[5.1]
  def change
    add_column :shifts, :state, :string
  end
end
