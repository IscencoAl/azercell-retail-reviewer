require 'rails_helper'

RSpec.describe "shop_items/index", :type => :view do
  before(:each) do
    assign(:shop_items, [
      ShopItem.create!(
        :item => nil,
        :shop => nil
      ),
      ShopItem.create!(
        :item => nil,
        :shop => nil
      )
    ])
  end

  it "renders a list of shop_items" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
