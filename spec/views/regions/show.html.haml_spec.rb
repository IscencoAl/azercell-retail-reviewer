require 'rails_helper'

RSpec.describe "regions/show", :type => :view do
  before(:each) do
    @region = assign(:region, Region.create!(
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
