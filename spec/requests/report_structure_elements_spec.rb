require 'rails_helper'

RSpec.describe "ReportStructureElements", :type => :request do
  describe "GET /report_structure_elements" do
    it "works! (now write some real specs)" do
      get report_structure_elements_path
      expect(response.status).to be(200)
    end
  end
end
