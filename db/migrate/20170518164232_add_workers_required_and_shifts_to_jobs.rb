class AddWorkersRequiredAndShiftsToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :workers_per_shift, :integer, default: 0
    add_column :jobs, :hours_per_shift, :integer, default: 0
    add_column :jobs, :shifts_required_per_day, :integer, default: 0
  end
end
