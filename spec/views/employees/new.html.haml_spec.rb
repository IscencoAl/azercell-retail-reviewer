require 'rails_helper'

RSpec.describe "employees/new", :type => :view do
  before(:each) do
    assign(:employee, Employee.new(
      :name => "MyString",
      :phone => "MyString",
      :shop_id => nil,
      :employee_workposition_id => nil,
      :is_deleted => false
    ))
  end

  it "renders new employee form" do
    render

    assert_select "form[action=?][method=?]", employees_path, "post" do

      assert_select "input#employee_name[name=?]", "employee[name]"

      assert_select "input#employee_phone[name=?]", "employee[phone]"

      assert_select "input#employee_shop_id_id[name=?]", "employee[shop_id_id]"

      assert_select "input#employee_employee_workposition_id_id[name=?]", "employee[employee_workposition_id_id]"

      assert_select "input#employee_is_deleted[name=?]", "employee[is_deleted]"
    end
  end
end
