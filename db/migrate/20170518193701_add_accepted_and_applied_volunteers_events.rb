class AddAcceptedAndAppliedVolunteersEvents < ActiveRecord::Migration[5.1]
  def change 
    create_table :event_accepted_volunteers, id: false do |t|
      t.belongs_to :event, type: :uuid, index: true
      t.belongs_to :user, type: :uuid, index: true
    end
    create_table :event_applied_volunteers, id: false do |t|
      t.belongs_to :event, type: :uuid, index: true
      t.belongs_to :user, type: :uuid, index: true
    end    
  end
end
