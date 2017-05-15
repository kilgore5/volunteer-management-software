require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    assign(:events, [
      Event.create!(
        :event_length => 2.5,
        :ticket_price_cents => 3,
        :client_owner => @user
      ),
      Event.create!(
        :event_length => 2.5,
        :ticket_price_cents => 3,
        :client_owner => @user
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
