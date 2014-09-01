require 'rails_helper'

RSpec.describe "users/new", :type => :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :surname => "MyString",
      :user_role => nil,
      :subscription => false,
      :is_deleted => false
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_surname[name=?]", "user[surname]"

      assert_select "input#user_user_role_id[name=?]", "user[user_role_id]"

      assert_select "input#user_subscription[name=?]", "user[subscription]"

      assert_select "input#user_is_deleted[name=?]", "user[is_deleted]"
    end
  end
end
