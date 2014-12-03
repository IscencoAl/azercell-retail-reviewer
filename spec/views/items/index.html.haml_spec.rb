require 'rails_helper'

RSpec.describe "items/index", :type => :view do
  before(:each) do
    assign(:shop_items, [
      Item.create!(
        :name => "Name",
        :is_deleted => false
      ),
      Item.create!(
        :name => "Name",
        :is_deleted => false
      )
    ])
  end

  it "renders a list of items" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
