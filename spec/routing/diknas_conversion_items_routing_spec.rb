require "rails_helper"

RSpec.describe DiknasConversionItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diknas_conversion_items").to route_to("diknas_conversion_items#index")
    end

    it "routes to #new" do
      expect(:get => "/diknas_conversion_items/new").to route_to("diknas_conversion_items#new")
    end

    it "routes to #show" do
      expect(:get => "/diknas_conversion_items/1").to route_to("diknas_conversion_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diknas_conversion_items/1/edit").to route_to("diknas_conversion_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diknas_conversion_items").to route_to("diknas_conversion_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/diknas_conversion_items/1").to route_to("diknas_conversion_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/diknas_conversion_items/1").to route_to("diknas_conversion_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diknas_conversion_items/1").to route_to("diknas_conversion_items#destroy", :id => "1")
    end

  end
end
