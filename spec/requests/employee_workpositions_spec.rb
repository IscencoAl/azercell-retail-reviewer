require 'rails_helper'

RSpec.describe "EmployeeWorkpositions", :type => :request do
  describe "GET /employee_workpositions" do
    it "works! (now write some real specs)" do
      get employee_workpositions_path
      expect(response.status).to be(200)
    end
  end
end
