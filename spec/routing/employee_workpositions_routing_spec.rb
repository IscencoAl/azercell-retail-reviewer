require "rails_helper"

RSpec.describe EmployeeWorkpositionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/employee_workpositions").to route_to("employee_workpositions#index")
    end

    it "routes to #new" do
      expect(:get => "/employee_workpositions/new").to route_to("employee_workpositions#new")
    end

    it "routes to #show" do
      expect(:get => "/employee_workpositions/1").to route_to("employee_workpositions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/employee_workpositions/1/edit").to route_to("employee_workpositions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/employee_workpositions").to route_to("employee_workpositions#create")
    end

    it "routes to #update" do
      expect(:put => "/employee_workpositions/1").to route_to("employee_workpositions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/employee_workpositions/1").to route_to("employee_workpositions#destroy", :id => "1")
    end

  end
end
