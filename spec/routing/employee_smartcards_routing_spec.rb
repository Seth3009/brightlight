require "rails_helper"

RSpec.describe EmployeeSmartcardsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/employee_smartcards").to route_to("employee_smartcards#index")
    end

    it "routes to #new" do
      expect(:get => "/employee_smartcards/new").to route_to("employee_smartcards#new")
    end

    it "routes to #show" do
      expect(:get => "/employee_smartcards/1").to route_to("employee_smartcards#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/employee_smartcards/1/edit").to route_to("employee_smartcards#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/employee_smartcards").to route_to("employee_smartcards#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/employee_smartcards/1").to route_to("employee_smartcards#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/employee_smartcards/1").to route_to("employee_smartcards#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/employee_smartcards/1").to route_to("employee_smartcards#destroy", :id => "1")
    end

  end
end
