require 'rails_helper'

RSpec.describe "shop_types/index", :type => :view do
  before(:each) do
    assign(:shop_types, [
      ShopType.create!(
        :name => "Name",
        :abbreviation => "Abbreviation",
        :is_deleted => false
      ),
      ShopType.create!(
        :name => "Name",
        :abbreviation => "Abbreviation",
        :is_deleted => false
      )
    ])
  end

  it "renders a list of shop_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Abbreviation".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
