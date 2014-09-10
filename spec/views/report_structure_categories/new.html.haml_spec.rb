require 'rails_helper'

RSpec.describe "report_structure_categories/new", :type => :view do
  before(:each) do
    assign(:report_structure_category, ReportStructureCategory.new(
      :name => "MyString"
    ))
  end

  it "renders new report_structure_category form" do
    render

    assert_select "form[action=?][method=?]", report_structure_categories_path, "post" do

      assert_select "input#report_structure_category_name[name=?]", "report_structure_category[name]"
    end
  end
end
