require 'rails_helper'

RSpec.describe "cities/new", :type => :view do
  before(:each) do
    assign(:city, City.new(
      :name => "MyString",
      :region => nil,
      :is_deleted => false
    ))
  end

  it "renders new city form" do
    render

    assert_select "form[action=?][method=?]", cities_path, "post" do

      assert_select "input#city_name[name=?]", "city[name]"

      assert_select "input#city_region_id[name=?]", "city[region_id]"

      assert_select "input#city_is_deleted[name=?]", "city[is_deleted]"
    end
  end
end
