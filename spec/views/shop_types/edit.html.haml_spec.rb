require 'rails_helper'

RSpec.describe "shop_types/edit", :type => :view do
  before(:each) do
    @shop_type = assign(:shop_type, ShopType.create!(
      :name => "MyString",
      :abbreviation => "MyString",
      :is_deleted => false
    ))
  end

  it "renders the edit shop_type form" do
    render

    assert_select "form[action=?][method=?]", shop_type_path(@shop_type), "post" do

      assert_select "input#shop_type_name[name=?]", "shop_type[name]"

      assert_select "input#shop_type_abbreviation[name=?]", "shop_type[abbreviation]"

      assert_select "input#shop_type_is_deleted[name=?]", "shop_type[is_deleted]"
    end
  end
end
