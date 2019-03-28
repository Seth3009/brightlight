require "rails_helper"

RSpec.describe FoodPackagesFoodSuppliersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/food_packages_food_suppliers").to route_to("food_packages_food_suppliers#index")
    end

    it "routes to #new" do
      expect(:get => "/food_packages_food_suppliers/new").to route_to("food_packages_food_suppliers#new")
    end

    it "routes to #show" do
      expect(:get => "/food_packages_food_suppliers/1").to route_to("food_packages_food_suppliers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/food_packages_food_suppliers/1/edit").to route_to("food_packages_food_suppliers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/food_packages_food_suppliers").to route_to("food_packages_food_suppliers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/food_packages_food_suppliers/1").to route_to("food_packages_food_suppliers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/food_packages_food_suppliers/1").to route_to("food_packages_food_suppliers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/food_packages_food_suppliers/1").to route_to("food_packages_food_suppliers#destroy", :id => "1")
    end

  end
end
