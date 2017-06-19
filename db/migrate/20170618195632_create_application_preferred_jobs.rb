class CreateApplicationPreferredJobs < ActiveRecord::Migration[5.1]
  def change

    create_table :application_preferred_jobs, id: :uuid do |t|
      t.belongs_to :job, type: :uuid, index: true
      t.belongs_to :application_for_event, type: :uuid, index: true
      t.timestamps
    end

  end
end
