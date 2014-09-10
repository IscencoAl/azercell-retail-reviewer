require 'rails_helper'

RSpec.describe "ReportStructureCategories", :type => :request do
  describe "GET /report_structure_categories" do
    it "works! (now write some real specs)" do
      get report_structure_categories_path
      expect(response.status).to be(200)
    end
  end
end
