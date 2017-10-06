class AddJobIdToApplies < ActiveRecord::Migration[5.1]
  def change
    add_column :applies, :job_id, :uuid, index: true
  end
end
