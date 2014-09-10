require 'rails_helper'

RSpec.describe "report_structure_categories/edit", :type => :view do
  before(:each) do
    @report_structure_category = assign(:report_structure_category, ReportStructureCategory.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit report_structure_category form" do
    render

    assert_select "form[action=?][method=?]", report_structure_category_path(@report_structure_category), "post" do

      assert_select "input#report_structure_category_name[name=?]", "report_structure_category[name]"
    end
  end
end
