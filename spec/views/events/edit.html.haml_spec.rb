require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @event = assign(:event, Event.create!(
      :name => "Random Event Name",
      :start_time => DateTime.now + 30.days,
      :end_time => DateTime.now + 33.days,
      :ticket_price_cents => 1,
      :client_owner => @user
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input[name=?]", "event[ticket_price_cents]"

    end
  end
end
