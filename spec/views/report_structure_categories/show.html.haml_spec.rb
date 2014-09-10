require 'rails_helper'

RSpec.describe "report_structure_categories/show", :type => :view do
  before(:each) do
    @report_structure_category = assign(:report_structure_category, ReportStructureCategory.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
