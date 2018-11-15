require "rails_helper"

RSpec.describe DiknasConversionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diknas_conversions").to route_to("diknas_conversions#index")
    end

    it "routes to #new" do
      expect(:get => "/diknas_conversions/new").to route_to("diknas_conversions#new")
    end

    it "routes to #show" do
      expect(:get => "/diknas_conversions/1").to route_to("diknas_conversions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diknas_conversions/1/edit").to route_to("diknas_conversions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diknas_conversions").to route_to("diknas_conversions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/diknas_conversions/1").to route_to("diknas_conversions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/diknas_conversions/1").to route_to("diknas_conversions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diknas_conversions/1").to route_to("diknas_conversions#destroy", :id => "1")
    end

  end
end
