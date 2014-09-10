require 'rails_helper'

RSpec.describe "report_structure_categories/index", :type => :view do
  before(:each) do
    assign(:report_structure_categories, [
      ReportStructureCategory.create!(
        :name => "Name"
      ),
      ReportStructureCategory.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of report_structure_categories" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
