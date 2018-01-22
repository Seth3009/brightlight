require "rails_helper"

RSpec.describe ItemUnitsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/item_units").to route_to("item_units#index")
    end

    it "routes to #new" do
      expect(:get => "/item_units/new").to route_to("item_units#new")
    end

    it "routes to #show" do
      expect(:get => "/item_units/1").to route_to("item_units#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/item_units/1/edit").to route_to("item_units#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/item_units").to route_to("item_units#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/item_units/1").to route_to("item_units#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/item_units/1").to route_to("item_units#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/item_units/1").to route_to("item_units#destroy", :id => "1")
    end

  end
end
