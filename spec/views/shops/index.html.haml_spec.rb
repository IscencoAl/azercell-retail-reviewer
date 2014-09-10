require 'rails_helper'

RSpec.describe "shops/index", :type => :view do
  before(:each) do
    assign(:shops, [
      Shop.create!(
        :shop_type => nil,
        :city => nil,
        :adress => "Adress",
        :latitude => "9.99",
        :longitude => "9.99",
        :dealer => nil,
        :square_footage => "9.99",
        :user => nil,
        :is_deleted => false
      ),
      Shop.create!(
        :shop_type => nil,
        :city => nil,
        :adress => "Adress",
        :latitude => "9.99",
        :longitude => "9.99",
        :dealer => nil,
        :square_footage => "9.99",
        :user => nil,
        :is_deleted => false
      )
    ])
  end

  it "renders a list of shops" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Adress".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
