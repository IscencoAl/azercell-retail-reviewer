require 'rails_helper'

RSpec.describe "shop_types/new", :type => :view do
  before(:each) do
    assign(:shop_type, ShopType.new(
      :name => "MyString",
      :abbreviation => "MyString",
      :is_deleted => false
    ))
  end

  it "renders new shop_type form" do
    render

    assert_select "form[action=?][method=?]", shop_types_path, "post" do

      assert_select "input#shop_type_name[name=?]", "shop_type[name]"

      assert_select "input#shop_type_abbreviation[name=?]", "shop_type[abbreviation]"

      assert_select "input#shop_type_is_deleted[name=?]", "shop_type[is_deleted]"
    end
  end
end
