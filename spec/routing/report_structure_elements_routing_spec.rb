require "rails_helper"

RSpec.describe ReportStructureElementsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/report_structure_elements").to route_to("report_structure_elements#index")
    end

    it "routes to #new" do
      expect(:get => "/report_structure_elements/new").to route_to("report_structure_elements#new")
    end

    it "routes to #show" do
      expect(:get => "/report_structure_elements/1").to route_to("report_structure_elements#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/report_structure_elements/1/edit").to route_to("report_structure_elements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/report_structure_elements").to route_to("report_structure_elements#create")
    end

    it "routes to #update" do
      expect(:put => "/report_structure_elements/1").to route_to("report_structure_elements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/report_structure_elements/1").to route_to("report_structure_elements#destroy", :id => "1")
    end

  end
end
