require "rails_helper"

RSpec.describe PurchaseReceivesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/purchase_receives").to route_to("purchase_receives#index")
    end

    it "routes to #new" do
      expect(:get => "/purchase_receives/new").to route_to("purchase_receives#new")
    end

    it "routes to #show" do
      expect(:get => "/purchase_receives/1").to route_to("purchase_receives#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/purchase_receives/1/edit").to route_to("purchase_receives#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/purchase_receives").to route_to("purchase_receives#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/purchase_receives/1").to route_to("purchase_receives#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/purchase_receives/1").to route_to("purchase_receives#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/purchase_receives/1").to route_to("purchase_receives#destroy", :id => "1")
    end

  end
end
