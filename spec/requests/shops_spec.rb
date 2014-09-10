require 'rails_helper'

RSpec.describe "Shops", :type => :request do
  describe "GET /shops" do
    it "works! (now write some real specs)" do
      get shops_path
      expect(response.status).to be(200)
    end
  end
end
