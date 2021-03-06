require 'rails_helper'

RSpec.describe "report_structure_elements/edit", :type => :view do
  before(:each) do
    @report_structure_element = assign(:report_structure_element, ReportStructureElement.create!(
      :name => "MyString",
      :report_structure_element_type => nil,
      :report_structure_category => nil,
      :weight => 1,
      :shop_types => "MyString"
    ))
  end

  it "renders the edit report_structure_element form" do
    render

    assert_select "form[action=?][method=?]", report_structure_element_path(@report_structure_element), "post" do

      assert_select "input#report_structure_element_name[name=?]", "report_structure_element[name]"

      assert_select "input#report_structure_element_report_structure_element_type_id[name=?]", "report_structure_element[report_structure_element_type_id]"

      assert_select "input#report_structure_element_report_structure_category_id[name=?]", "report_structure_element[report_structure_category_id]"

      assert_select "input#report_structure_element_weight[name=?]", "report_structure_element[weight]"

      assert_select "input#report_structure_element_shop_types[name=?]", "report_structure_element[shop_types]"
    end
  end
end
