require "rails_helper"

RSpec.describe SuppliesTransactionItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/supplies_transaction_items").to route_to("supplies_transaction_items#index")
    end

    it "routes to #new" do
      expect(:get => "/supplies_transaction_items/new").to route_to("supplies_transaction_items#new")
    end

    it "routes to #show" do
      expect(:get => "/supplies_transaction_items/1").to route_to("supplies_transaction_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/supplies_transaction_items/1/edit").to route_to("supplies_transaction_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/supplies_transaction_items").to route_to("supplies_transaction_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/supplies_transaction_items/1").to route_to("supplies_transaction_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/supplies_transaction_items/1").to route_to("supplies_transaction_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/supplies_transaction_items/1").to route_to("supplies_transaction_items#destroy", :id => "1")
    end

  end
end
