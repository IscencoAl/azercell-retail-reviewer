require 'rails_helper'

RSpec.describe "Dealers", :type => :request do
  describe "GET /dealers" do
    it "works! (now write some real specs)" do
      get dealers_path
      expect(response.status).to be(200)
    end
  end
end
