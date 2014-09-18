require 'rails_helper'

RSpec.describe ReportsController, :type => :controller do

  describe "GET index" do
    it "populates an array of reports" do
      user = create(:user, :admin)
      sign_in user

      report = create(:report)

      get :index
      expect(assigns(:reports)).to eq([report])
    end

    it "filters reports" do
      admin = create(:user, :admin)
      sign_in admin

      reviewer = create(:user, :reviewer)
      report = create(:report, :user => reviewer)

      get :index, {:filter => {:user => reviewer.id}}
      expect(assigns(:reports)).to eq([report])
    end

    it "renders the index view" do
      user = create(:user, :admin)
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    it "assignes the requested report as @report" do
      user = create(:user, :admin)
      sign_in user

      report = create(:report)

      get :show, {:id => report.to_param}
      expect(assigns(:report)).to eq(report)
    end

    it "renders the show view" do
      user = create(:user, :admin)
      sign_in user

      report = create(:report)

      get :show, {:id => report.to_param}
      expect(response).to render_template(:show)
    end
  end

end