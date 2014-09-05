require 'rails_helper'

RSpec.describe "dealers/index", :type => :view do
  before(:each) do
    assign(:dealers, [
      Dealer.create!(
        :name => "Name",
        :contact_name => "Contact Name",
        :phone_number => "Phone Number",
        :email => "Email",
        :is_deleted => false
      ),
      Dealer.create!(
        :name => "Name",
        :contact_name => "Contact Name",
        :phone_number => "Phone Number",
        :email => "Email",
        :is_deleted => false
      )
    ])
  end

  it "renders a list of dealers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
