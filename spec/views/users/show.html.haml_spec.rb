require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "First",
      :last_name => "Last",
      :email => "aisudgf@asjdfdsah.online",
      :mobile_number => "Mobile Number",
      :password => "p864c5apiostvnot7rw3x4",
      :slug => "Slug",
      :shifts_made => 2,
      :shifts_missed => 3,
      :apps_accepted => 4,
      :hours_worked => 5,
      :rating => 6.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First/)
    expect(rendered).to match(/Last/)
    expect(rendered).to match(/First Last/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Mobile Number/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6.5/)
  end
end
