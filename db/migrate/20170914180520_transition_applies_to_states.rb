class TransitionAppliesToStates < ActiveRecord::Migration[5.1]
  def change

    @accepted    = Apply.where(accepted: true)
    @denied      = Apply.where(denied: true)

    @accepted.each {|app| app.accept!}
    @accepted.each {|app| app.deny!}

    remove_column :applies, :accepted
    remove_column :applies, :denied

  end
end
