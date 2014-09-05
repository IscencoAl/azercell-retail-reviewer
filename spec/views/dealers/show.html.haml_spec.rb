require 'rails_helper'

RSpec.describe "dealers/show", :type => :view do
  before(:each) do
    @dealer = assign(:dealer, Dealer.create!(
      :name => "Name",
      :contact_name => "Contact Name",
      :phone_number => "Phone Number",
      :email => "Email",
      :is_deleted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Contact Name/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/false/)
  end
end
