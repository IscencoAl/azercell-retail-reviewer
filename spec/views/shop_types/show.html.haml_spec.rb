require 'rails_helper'

RSpec.describe "shop_types/show", :type => :view do
  before(:each) do
    @shop_type = assign(:shop_type, ShopType.create!(
      :name => "Name",
      :abbreviation => "Abbreviation",
      :is_deleted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Abbreviation/)
    expect(rendered).to match(/false/)
  end
end
