require "rails_helper"

RSpec.describe ShopTypesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shop_types").to route_to("shop_types#index")
    end

    it "routes to #new" do
      expect(:get => "/shop_types/new").to route_to("shop_types#new")
    end

    it "routes to #show" do
      expect(:get => "/shop_types/1").to route_to("shop_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shop_types/1/edit").to route_to("shop_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shop_types").to route_to("shop_types#create")
    end

    it "routes to #update" do
      expect(:put => "/shop_types/1").to route_to("shop_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shop_types/1").to route_to("shop_types#destroy", :id => "1")
    end

  end
end
