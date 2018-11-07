require "rails_helper"

RSpec.describe DiknasGradebooksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diknas_gradebooks").to route_to("diknas_gradebooks#index")
    end

    it "routes to #new" do
      expect(:get => "/diknas_gradebooks/new").to route_to("diknas_gradebooks#new")
    end

    it "routes to #show" do
      expect(:get => "/diknas_gradebooks/1").to route_to("diknas_gradebooks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diknas_gradebooks/1/edit").to route_to("diknas_gradebooks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diknas_gradebooks").to route_to("diknas_gradebooks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/diknas_gradebooks/1").to route_to("diknas_gradebooks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/diknas_gradebooks/1").to route_to("diknas_gradebooks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diknas_gradebooks/1").to route_to("diknas_gradebooks#destroy", :id => "1")
    end

  end
end
