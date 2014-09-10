require 'rails_helper'

RSpec.describe "shops/show", :type => :view do
  before(:each) do
    @shop = assign(:shop, Shop.create!(
      :shop_type => nil,
      :city => nil,
      :adress => "Adress",
      :latitude => "9.99",
      :longitude => "9.99",
      :dealer => nil,
      :square_footage => "9.99",
      :user => nil,
      :is_deleted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Adress/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
