require 'rails_helper'

RSpec.describe "shop_items/show", :type => :view do
  before(:each) do
    @shop_item = assign(:shop_item, ShopItem.create!(
      :item => nil,
      :shop => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
