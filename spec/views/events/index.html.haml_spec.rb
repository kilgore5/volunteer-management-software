require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    assign(:events, [
      Event.create!(
        :name => "Random Event Name",
        :start_time => DateTime.now + 30.days,
        :end_time => DateTime.now + 33.days,        
        :ticket_price_cents => 3000,
        :client_owner => @user
      ),
      Event.create!(
        :name => "another Event Name",
        :start_time => DateTime.now + 60.days,
        :end_time => DateTime.now + 63.days,    
        :ticket_price_cents => 3000,
        :client_owner => @user
      )
    ])
  end

  it "renders a list of events" do
    render
    # assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
