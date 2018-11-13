require "rails_helper"

RSpec.describe RawFoodsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/raw_foods").to route_to("raw_foods#index")
    end

    it "routes to #new" do
      expect(:get => "/raw_foods/new").to route_to("raw_foods#new")
    end

    it "routes to #show" do
      expect(:get => "/raw_foods/1").to route_to("raw_foods#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/raw_foods/1/edit").to route_to("raw_foods#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/raw_foods").to route_to("raw_foods#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/raw_foods/1").to route_to("raw_foods#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/raw_foods/1").to route_to("raw_foods#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/raw_foods/1").to route_to("raw_foods#destroy", :id => "1")
    end

  end
end
