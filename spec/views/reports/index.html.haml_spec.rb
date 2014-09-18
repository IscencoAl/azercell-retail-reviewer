require 'rails_helper'

RSpec.describe "reports/index", :type => :view do
  before(:each) do
    assign(:reports, [
      Report.create!(
        :latitude => "9.99",
        :longitude => "9.99",
        :user => nil,
        :shop => nil,
        :score => "9.99"
      ),
      Report.create!(
        :latitude => "9.99",
        :longitude => "9.99",
        :user => nil,
        :shop => nil,
        :score => "9.99"
      )
    ])
  end

  it "renders a list of reports" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
