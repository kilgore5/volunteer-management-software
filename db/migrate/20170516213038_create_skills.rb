class CreateSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :skills, id: :uuid do |t|
      t.string :name
      t.belongs_to :user, type: :uuid, index: true
      t.attachment :proof_document

      t.timestamps
    end
  end
end
