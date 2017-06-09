class AddSlugToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :slug, :string, unique: true
    add_index :jobs, :slug
  end
end
