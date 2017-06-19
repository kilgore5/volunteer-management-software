class AddMedicalConditionToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.text :medical_conditions
    end
  end
end
