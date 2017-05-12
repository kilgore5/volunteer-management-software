require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :first_name => "Joe",
        :last_name => "Blowhard",
        :full_name => "Joe Blowhard",
        :email => "joe@blowhard.com",
        :mobile_number => "0434-234-234",
        :password => "asdfhj123123!@adsfsad.c",        
        :slug => "jow-blowhard",
        :shifts_made => 0,
        :shifts_missed => 0,
        :apps_accepted => 0,
        :hours_worked => 0,
        :rating => 0.0
      ),
      User.create!(
        :first_name => "Sarahs",
        :last_name => "Jones",
        :full_name => "Sarah Jones",
        :email => "sarah@asdfsdaf.com",
        :mobile_number => "2354243524352",
        :password => ".,.masndf83hrhifqafhi_",        
        :slug => "sarah-jones",
        :shifts_made => 0,
        :shifts_missed => 0,
        :apps_accepted => 0,
        :hours_worked => 0,
        :rating => 0.0
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :count => 30
    # assert_select "tr>td", :count => 2
    # assert_select "tr>td", :count => 2
    # assert_select "tr>td", :count => 2
    # assert_select "tr>td", :count => 2
    # assert_select "tr>td", :count => 2
    # assert_select "tr>td", :count => 2
    # assert_select "tr>td", :count => 2
    # assert_select "tr>td", :count => 2
    # assert_select "tr>td", :count => 2
    # assert_select "tr>td", :count => 2
  end
end
