class AddJobsToEventDays < ActiveRecord::Migration[5.1]
  def change 
    create_table :event_days_jobs, id: false do |t|
      t.belongs_to :event_day, type: :uuid, index: true
      t.belongs_to :job, type: :uuid, index: true
    end
  end
end
