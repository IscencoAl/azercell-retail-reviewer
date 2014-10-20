require "rails_helper"

RSpec.describe ShopItemsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shop_items").to route_to("shop_items#index")
    end

    it "routes to #new" do
      expect(:get => "/shop_items/new").to route_to("shop_items#new")
    end

    it "routes to #show" do
      expect(:get => "/shop_items/1").to route_to("shop_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shop_items/1/edit").to route_to("shop_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shop_items").to route_to("shop_items#create")
    end

    it "routes to #update" do
      expect(:put => "/shop_items/1").to route_to("shop_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shop_items/1").to route_to("shop_items#destroy", :id => "1")
    end

  end
end
