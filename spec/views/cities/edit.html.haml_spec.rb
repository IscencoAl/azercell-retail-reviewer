require 'rails_helper'

RSpec.describe "cities/edit", :type => :view do
  before(:each) do
    @city = assign(:city, City.create!(
      :name => "MyString",
      :region => nil,
      :is_deleted => false
    ))
  end

  it "renders the edit city form" do
    render

    assert_select "form[action=?][method=?]", city_path(@city), "post" do

      assert_select "input#city_name[name=?]", "city[name]"

      assert_select "input#city_region_id[name=?]", "city[region_id]"

      assert_select "input#city_is_deleted[name=?]", "city[is_deleted]"
    end
  end
end
