require "rails_helper"

RSpec.describe FoodPacksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/food_packs").to route_to("food_packs#index")
    end

    it "routes to #new" do
      expect(:get => "/food_packs/new").to route_to("food_packs#new")
    end

    it "routes to #show" do
      expect(:get => "/food_packs/1").to route_to("food_packs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/food_packs/1/edit").to route_to("food_packs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/food_packs").to route_to("food_packs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/food_packs/1").to route_to("food_packs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/food_packs/1").to route_to("food_packs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/food_packs/1").to route_to("food_packs#destroy", :id => "1")
    end

  end
end
