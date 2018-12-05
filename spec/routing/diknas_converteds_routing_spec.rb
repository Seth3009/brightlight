require "rails_helper"

RSpec.describe DiknasConvertedsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diknas_converteds").to route_to("diknas_converteds#index")
    end

    it "routes to #new" do
      expect(:get => "/diknas_converteds/new").to route_to("diknas_converteds#new")
    end

    it "routes to #show" do
      expect(:get => "/diknas_converteds/1").to route_to("diknas_converteds#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diknas_converteds/1/edit").to route_to("diknas_converteds#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diknas_converteds").to route_to("diknas_converteds#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/diknas_converteds/1").to route_to("diknas_converteds#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/diknas_converteds/1").to route_to("diknas_converteds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diknas_converteds/1").to route_to("diknas_converteds#destroy", :id => "1")
    end

  end
end
