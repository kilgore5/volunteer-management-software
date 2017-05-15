require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    assign(:event, Event.new(
      :event_length => 1.5,
      :ticket_price_cents => 1,
      :client_owner => @user
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[event_length]"

      assert_select "input[name=?]", "event[ticket_price_cents]"
      
    end
  end
end
