require 'rails_helper'

RSpec.describe "shops/edit", :type => :view do
  before(:each) do
    @shop = assign(:shop, Shop.create!(
      :shop_type => nil,
      :city => nil,
      :adress => "MyString",
      :latitude => "9.99",
      :longitude => "9.99",
      :dealer => nil,
      :square_footage => "9.99",
      :user => nil,
      :is_deleted => false
    ))
  end

  it "renders the edit shop form" do
    render

    assert_select "form[action=?][method=?]", shop_path(@shop), "post" do

      assert_select "input#shop_shop_type_id[name=?]", "shop[shop_type_id]"

      assert_select "input#shop_city_id[name=?]", "shop[city_id]"

      assert_select "input#shop_adress[name=?]", "shop[adress]"

      assert_select "input#shop_latitude[name=?]", "shop[latitude]"

      assert_select "input#shop_longitude[name=?]", "shop[longitude]"

      assert_select "input#shop_dealer_id[name=?]", "shop[dealer_id]"

      assert_select "input#shop_square_footage[name=?]", "shop[square_footage]"

      assert_select "input#shop_user_id[name=?]", "shop[user_id]"

      assert_select "input#shop_is_deleted[name=?]", "shop[is_deleted]"
    end
  end
end
