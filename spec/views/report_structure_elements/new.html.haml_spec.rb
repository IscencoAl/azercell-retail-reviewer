require 'rails_helper'

RSpec.describe "report_structure_elements/new", :type => :view do
  before(:each) do
    assign(:report_structure_element, ReportStructureElement.new(
      :name => "MyString",
      :report_structure_element_type => nil,
      :report_structure_category => nil,
      :weight => 1,
      :shop_types => "MyString"
    ))
  end

  it "renders new report_structure_element form" do
    render

    assert_select "form[action=?][method=?]", report_structure_elements_path, "post" do

      assert_select "input#report_structure_element_name[name=?]", "report_structure_element[name]"

      assert_select "input#report_structure_element_report_structure_element_type_id[name=?]", "report_structure_element[report_structure_element_type_id]"

      assert_select "input#report_structure_element_report_structure_category_id[name=?]", "report_structure_element[report_structure_category_id]"

      assert_select "input#report_structure_element_weight[name=?]", "report_structure_element[weight]"

      assert_select "input#report_structure_element_shop_types[name=?]", "report_structure_element[shop_types]"
    end
  end
end
