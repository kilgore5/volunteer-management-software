class AddSlugToEventDay < ActiveRecord::Migration[5.1]
  def change
    add_column :event_days, :slug, :string, unique: true
    add_index :event_days, :slug
  end
end
