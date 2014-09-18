require 'rails_helper'

RSpec.describe "reports/new", :type => :view do
  before(:each) do
    assign(:report, Report.new(
      :latitude => "9.99",
      :longitude => "9.99",
      :user => nil,
      :shop => nil,
      :score => "9.99"
    ))
  end

  it "renders new report form" do
    render

    assert_select "form[action=?][method=?]", reports_path, "post" do

      assert_select "input#report_latitude[name=?]", "report[latitude]"

      assert_select "input#report_longitude[name=?]", "report[longitude]"

      assert_select "input#report_user_id[name=?]", "report[user_id]"

      assert_select "input#report_shop_id[name=?]", "report[shop_id]"

      assert_select "input#report_score[name=?]", "report[score]"
    end
  end
end
