class AddApplicationClosingDateToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :application_closing_date, :datetime
  end
end
