class AddSlugToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :slug, :string, unique: true
    add_index :events, :slug
  end
end
