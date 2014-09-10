require "rails_helper"

RSpec.describe ReportStructureCategoriesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/report_structure_categories").to route_to("report_structure_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/report_structure_categories/new").to route_to("report_structure_categories#new")
    end

    it "routes to #show" do
      expect(:get => "/report_structure_categories/1").to route_to("report_structure_categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/report_structure_categories/1/edit").to route_to("report_structure_categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/report_structure_categories").to route_to("report_structure_categories#create")
    end

    it "routes to #update" do
      expect(:put => "/report_structure_categories/1").to route_to("report_structure_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/report_structure_categories/1").to route_to("report_structure_categories#destroy", :id => "1")
    end

  end
end
