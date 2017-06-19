class CreateJobDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :job_departments, id: :uuid do |t|
      t.string :name
      t.timestamps
    end

    create_table :volunteer_preferred_departments, id: :uuid do |t|
      t.string :name
      t.belongs_to :user, type: :uuid, index: true
      t.belongs_to :job_department, type: :uuid, index: true
      t.timestamps
    end    
  end
end
