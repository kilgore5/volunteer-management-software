class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :title
      t.text :description
      t.belongs_to :event, type: :uuid, index: true

      t.timestamps
    end
  end
end
