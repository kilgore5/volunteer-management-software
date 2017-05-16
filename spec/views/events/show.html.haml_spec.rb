require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @event = assign(:event, Event.create!(
      :name => "Random Event Name",      
      :start_time => DateTime.now + 30.days,
      :end_time => DateTime.now + 33.days,
      :ticket_price_cents => 3,
      :client_owner => @user
    ))
  end

  it "renders attributes in <p>" do
    render
    # expect(rendered).to match(/2.5/)
    # expect(rendered).to match(/3/)
    # expect(rendered).to match(//)
  end
end
