require 'rails_helper'

RSpec.describe "shop_items/new", :type => :view do
  before(:each) do
    assign(:shop_item, ShopItem.new(
      :item => nil,
      :shop => nil
    ))
  end

  it "renders new shop_item form" do
    render

    assert_select "form[action=?][method=?]", shop_items_path, "post" do

      assert_select "input#shop_item_item_id[name=?]", "shop_item[item_id]"

      assert_select "input#shop_item_shop_id[name=?]", "shop_item[shop_id]"
    end
  end
end
