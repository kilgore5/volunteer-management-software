class MakeAllAppsSubmitted < ActiveRecord::Migration[5.1]
  def change
    apps = Apply.where state: nil
    apps.update_all state: "submitted"
    change_column :applies, :state, :string, default: "submitted"
  end
end
