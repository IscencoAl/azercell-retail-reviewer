require 'rails_helper'

RSpec.describe "ShopTypes", :type => :request do
  describe "GET /shop_types" do
    it "works! (now write some real specs)" do
      get shop_types_path
      expect(response.status).to be(200)
    end
  end
end
