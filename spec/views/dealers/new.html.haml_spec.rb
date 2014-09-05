require 'rails_helper'

RSpec.describe "dealers/new", :type => :view do
  before(:each) do
    assign(:dealer, Dealer.new(
      :name => "MyString",
      :contact_name => "MyString",
      :phone_number => "MyString",
      :email => "MyString",
      :is_deleted => false
    ))
  end

  it "renders new dealer form" do
    render

    assert_select "form[action=?][method=?]", dealers_path, "post" do

      assert_select "input#dealer_name[name=?]", "dealer[name]"

      assert_select "input#dealer_contact_name[name=?]", "dealer[contact_name]"

      assert_select "input#dealer_phone_number[name=?]", "dealer[phone_number]"

      assert_select "input#dealer_email[name=?]", "dealer[email]"

      assert_select "input#dealer_is_deleted[name=?]", "dealer[is_deleted]"
    end
  end
end
