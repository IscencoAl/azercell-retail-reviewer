require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, create(:user))
  end

  it "renders the edit user form" do
    render
  end
end
