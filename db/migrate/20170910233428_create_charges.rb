class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges, id: :uuid do |t|
      t.belongs_to :event, type: :uuid, index: true
      t.belongs_to :user, type: :uuid, index: true
      t.monetize :amount
      t.string :description
      t.string :stripe_id

      t.timestamps
    end
  end
end
