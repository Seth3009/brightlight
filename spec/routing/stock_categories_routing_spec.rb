require "rails_helper"

RSpec.describe StockCategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/stock_categories").to route_to("stock_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/stock_categories/new").to route_to("stock_categories#new")
    end

    it "routes to #show" do
      expect(:get => "/stock_categories/1").to route_to("stock_categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/stock_categories/1/edit").to route_to("stock_categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/stock_categories").to route_to("stock_categories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/stock_categories/1").to route_to("stock_categories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/stock_categories/1").to route_to("stock_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/stock_categories/1").to route_to("stock_categories#destroy", :id => "1")
    end

  end
end
