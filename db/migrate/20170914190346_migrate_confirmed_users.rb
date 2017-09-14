class MigrateConfirmedUsers < ActiveRecord::Migration[5.1]
  def change

    @confirmed   = Apply.where(invitation_accepted: true)

    @confirmed.each {|app| app.confirm!}

    remove_column :applies, :invitation_accepted

  end
end
