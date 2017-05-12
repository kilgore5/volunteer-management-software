require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :first_name => "MyString",
      :last_name => "MyString",
      :full_name => "MyString",
      :email => "MyString",
      :mobile_number => "MyString",
      :slug => "MyString",
      :shifts_made => 1,
      :shifts_missed => 1,
      :apps_accepted => 1,
      :hours_worked => 1,
      :rating => 1.5
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "input[name=?]", "user[full_name]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[mobile_number]"

      assert_select "input[name=?]", "user[slug]"

      assert_select "input[name=?]", "user[shifts_made]"

      assert_select "input[name=?]", "user[shifts_missed]"

      assert_select "input[name=?]", "user[apps_accepted]"

      assert_select "input[name=?]", "user[hours_worked]"

      assert_select "input[name=?]", "user[rating]"
    end
  end
end
