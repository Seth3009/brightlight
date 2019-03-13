require "rails_helper"

RSpec.describe FoodOrdersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/food_orders").to route_to("food_orders#index")
    end

    it "routes to #new" do
      expect(:get => "/food_orders/new").to route_to("food_orders#new")
    end

    it "routes to #show" do
      expect(:get => "/food_orders/1").to route_to("food_orders#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/food_orders/1/edit").to route_to("food_orders#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/food_orders").to route_to("food_orders#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/food_orders/1").to route_to("food_orders#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/food_orders/1").to route_to("food_orders#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/food_orders/1").to route_to("food_orders#destroy", :id => "1")
    end

  end
end
