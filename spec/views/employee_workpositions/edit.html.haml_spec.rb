require 'rails_helper'

RSpec.describe "employee_workpositions/edit", :type => :view do
  before(:each) do
    @employee_workposition = assign(:employee_workposition, EmployeeWorkposition.create!(
      :name => "MyString",
      :is_deleted => false
    ))
  end

  it "renders the edit employee_workposition form" do
    render

    assert_select "form[action=?][method=?]", employee_workposition_path(@employee_workposition), "post" do

      assert_select "input#employee_workposition_name[name=?]", "employee_workposition[name]"

      assert_select "input#employee_workposition_is_deleted[name=?]", "employee_workposition[is_deleted]"
    end
  end
end
