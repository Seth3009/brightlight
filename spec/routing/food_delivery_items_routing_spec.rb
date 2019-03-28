require "rails_helper"

RSpec.describe FoodDeliveryItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/food_delivery_items").to route_to("food_delivery_items#index")
    end

    it "routes to #new" do
      expect(:get => "/food_delivery_items/new").to route_to("food_delivery_items#new")
    end

    it "routes to #show" do
      expect(:get => "/food_delivery_items/1").to route_to("food_delivery_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/food_delivery_items/1/edit").to route_to("food_delivery_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/food_delivery_items").to route_to("food_delivery_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/food_delivery_items/1").to route_to("food_delivery_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/food_delivery_items/1").to route_to("food_delivery_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/food_delivery_items/1").to route_to("food_delivery_items#destroy", :id => "1")
    end

  end
end
