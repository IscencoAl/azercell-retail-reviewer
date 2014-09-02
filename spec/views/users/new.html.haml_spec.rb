require 'rails_helper'

RSpec.describe "users/new", :type => :view do
  before(:each) do
    assign(:user, create(:user))
  end

  it "renders new user form" do
    render
  end
end
