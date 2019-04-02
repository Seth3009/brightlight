require "rails_helper"

RSpec.describe FoodDeliveriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/food_deliveries").to route_to("food_deliveries#index")
    end

    it "routes to #new" do
      expect(:get => "/food_deliveries/new").to route_to("food_deliveries#new")
    end

    it "routes to #show" do
      expect(:get => "/food_deliveries/1").to route_to("food_deliveries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/food_deliveries/1/edit").to route_to("food_deliveries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/food_deliveries").to route_to("food_deliveries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/food_deliveries/1").to route_to("food_deliveries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/food_deliveries/1").to route_to("food_deliveries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/food_deliveries/1").to route_to("food_deliveries#destroy", :id => "1")
    end

  end
end
