require 'rails_helper'

RSpec.describe "cities/index", :type => :view do
  before(:each) do
    assign(:cities, [
      City.create!(
        :name => "Name",
        :region => nil,
        :is_deleted => false
      ),
      City.create!(
        :name => "Name",
        :region => nil,
        :is_deleted => false
      )
    ])
  end

  it "renders a list of cities" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
