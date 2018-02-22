require "rails_helper"

RSpec.describe SuppliesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/supplies").to route_to("supplies#index")
    end

    it "routes to #new" do
      expect(:get => "/supplies/new").to route_to("supplies#new")
    end

    it "routes to #show" do
      expect(:get => "/supplies/1").to route_to("supplies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/supplies/1/edit").to route_to("supplies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/supplies").to route_to("supplies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/supplies/1").to route_to("supplies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/supplies/1").to route_to("supplies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/supplies/1").to route_to("supplies#destroy", :id => "1")
    end

  end
end
