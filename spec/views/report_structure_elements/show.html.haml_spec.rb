require 'rails_helper'

RSpec.describe "report_structure_elements/show", :type => :view do
  before(:each) do
    @report_structure_element = assign(:report_structure_element, ReportStructureElement.create!(
      :name => "Name",
      :report_structure_element_type => nil,
      :report_structure_category => nil,
      :weight => 1,
      :shop_types => "Shop Types"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Shop Types/)
  end
end
