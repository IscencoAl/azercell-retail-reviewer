require 'rails_helper'

RSpec.describe "report_structure_elements/index", :type => :view do
  before(:each) do
    assign(:report_structure_elements, [
      ReportStructureElement.create!(
        :name => "Name",
        :report_structure_element_type => nil,
        :report_structure_category => nil,
        :weight => 1,
        :shop_types => "Shop Types"
      ),
      ReportStructureElement.create!(
        :name => "Name",
        :report_structure_element_type => nil,
        :report_structure_category => nil,
        :weight => 1,
        :shop_types => "Shop Types"
      )
    ])
  end

  it "renders a list of report_structure_elements" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Shop Types".to_s, :count => 2
  end
end
