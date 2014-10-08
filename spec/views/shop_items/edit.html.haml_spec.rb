require 'rails_helper'

RSpec.describe "shop_items/edit", :type => :view do
  before(:each) do
    @shop_item = assign(:shop_item, ShopItem.create!(
      :item => nil,
      :shop => nil
    ))
  end

  it "renders the edit shop_item form" do
    render

    assert_select "form[action=?][method=?]", shop_item_path(@shop_item), "post" do

      assert_select "input#shop_item_item_id[name=?]", "shop_item[item_id]"

      assert_select "input#shop_item_shop_id[name=?]", "shop_item[shop_id]"
    end
  end
end
