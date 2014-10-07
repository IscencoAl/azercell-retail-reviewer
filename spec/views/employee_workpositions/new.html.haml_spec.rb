require 'rails_helper'

RSpec.describe "employee_workpositions/new", :type => :view do
  before(:each) do
    assign(:employee_workposition, EmployeeWorkposition.new(
      :name => "MyString",
      :is_deleted => false
    ))
  end

  it "renders new employee_workposition form" do
    render

    assert_select "form[action=?][method=?]", employee_workpositions_path, "post" do

      assert_select "input#employee_workposition_name[name=?]", "employee_workposition[name]"

      assert_select "input#employee_workposition_is_deleted[name=?]", "employee_workposition[is_deleted]"
    end
  end
end
