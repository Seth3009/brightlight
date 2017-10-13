require "rails_helper"

RSpec.describe DeliveryItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/delivery_items").to route_to("delivery_items#index")
    end

    it "routes to #new" do
      expect(:get => "/delivery_items/new").to route_to("delivery_items#new")
    end

    it "routes to #show" do
      expect(:get => "/delivery_items/1").to route_to("delivery_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/delivery_items/1/edit").to route_to("delivery_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/delivery_items").to route_to("delivery_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/delivery_items/1").to route_to("delivery_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/delivery_items/1").to route_to("delivery_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/delivery_items/1").to route_to("delivery_items#destroy", :id => "1")
    end

  end
end
