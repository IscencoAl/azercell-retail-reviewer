require 'rails_helper'

RSpec.describe "employee_workpositions/index", :type => :view do
  before(:each) do
    assign(:employee_workpositions, [
      EmployeeWorkposition.create!(
        :name => "Name",
        :is_deleted => false
      ),
      EmployeeWorkposition.create!(
        :name => "Name",
        :is_deleted => false
      )
    ])
  end

  it "renders a list of employee_workpositions" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
