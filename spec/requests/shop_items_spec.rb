require 'rails_helper'

RSpec.describe "ShopItems", :type => :request do
  describe "GET /shop_items" do
    it "works! (now write some real specs)" do
      get shop_items_path
      expect(response.status).to be(200)
    end
  end
end
