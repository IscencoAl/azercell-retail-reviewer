require 'rails_helper'

RSpec.describe "cities/show", :type => :view do
  before(:each) do
    @city = assign(:city, City.create!(
      :name => "Name",
      :region => nil,
      :is_deleted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
