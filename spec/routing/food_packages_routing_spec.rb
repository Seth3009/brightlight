require "rails_helper"

RSpec.describe FoodPackagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/food_packages").to route_to("food_packages#index")
    end

    it "routes to #new" do
      expect(:get => "/food_packages/new").to route_to("food_packages#new")
    end

    it "routes to #show" do
      expect(:get => "/food_packages/1").to route_to("food_packages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/food_packages/1/edit").to route_to("food_packages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/food_packages").to route_to("food_packages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/food_packages/1").to route_to("food_packages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/food_packages/1").to route_to("food_packages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/food_packages/1").to route_to("food_packages#destroy", :id => "1")
    end

  end
end
