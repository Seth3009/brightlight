require "rails_helper"

RSpec.describe SuppliesTransactionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/supplies_transactions").to route_to("supplies_transactions#index")
    end

    it "routes to #new" do
      expect(:get => "/supplies_transactions/new").to route_to("supplies_transactions#new")
    end

    it "routes to #show" do
      expect(:get => "/supplies_transactions/1").to route_to("supplies_transactions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/supplies_transactions/1/edit").to route_to("supplies_transactions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/supplies_transactions").to route_to("supplies_transactions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/supplies_transactions/1").to route_to("supplies_transactions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/supplies_transactions/1").to route_to("supplies_transactions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/supplies_transactions/1").to route_to("supplies_transactions#destroy", :id => "1")
    end

  end
end
