class CreateSkillRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :skill_requirements, id: :uuid do |t|
      t.belongs_to :job, type: :uuid, index: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
