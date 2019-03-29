require "rails_helper"

RSpec.describe ClassBudgetsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/class_budgets").to route_to("class_budgets#index")
    end

    it "routes to #new" do
      expect(:get => "/class_budgets/new").to route_to("class_budgets#new")
    end

    it "routes to #show" do
      expect(:get => "/class_budgets/1").to route_to("class_budgets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/class_budgets/1/edit").to route_to("class_budgets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/class_budgets").to route_to("class_budgets#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/class_budgets/1").to route_to("class_budgets#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/class_budgets/1").to route_to("class_budgets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/class_budgets/1").to route_to("class_budgets#destroy", :id => "1")
    end

  end
end
