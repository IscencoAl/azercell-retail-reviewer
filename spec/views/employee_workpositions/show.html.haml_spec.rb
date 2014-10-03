require 'rails_helper'

RSpec.describe "employee_workpositions/show", :type => :view do
  before(:each) do
    @employee_workposition = assign(:employee_workposition, EmployeeWorkposition.create!(
      :name => "Name",
      :is_deleted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
  end
end
