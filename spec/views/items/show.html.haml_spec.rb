require 'rails_helper'

RSpec.describe "items/show", :type => :view do
  before(:each) do
    @item = assign(:item, Item.create!(
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
