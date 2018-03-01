require "rails_helper"

RSpec.describe SuppliesStocksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/supplies_stocks").to route_to("supplies_stocks#index")
    end

    it "routes to #new" do
      expect(:get => "/supplies_stocks/new").to route_to("supplies_stocks#new")
    end

    it "routes to #show" do
      expect(:get => "/supplies_stocks/1").to route_to("supplies_stocks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/supplies_stocks/1/edit").to route_to("supplies_stocks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/supplies_stocks").to route_to("supplies_stocks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/supplies_stocks/1").to route_to("supplies_stocks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/supplies_stocks/1").to route_to("supplies_stocks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/supplies_stocks/1").to route_to("supplies_stocks#destroy", :id => "1")
    end

  end
end
