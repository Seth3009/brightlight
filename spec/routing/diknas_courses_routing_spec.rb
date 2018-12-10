require "rails_helper"

RSpec.describe DiknasCoursesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diknas_courses").to route_to("diknas_courses#index")
    end

    it "routes to #new" do
      expect(:get => "/diknas_courses/new").to route_to("diknas_courses#new")
    end

    it "routes to #show" do
      expect(:get => "/diknas_courses/1").to route_to("diknas_courses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diknas_courses/1/edit").to route_to("diknas_courses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diknas_courses").to route_to("diknas_courses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/diknas_courses/1").to route_to("diknas_courses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/diknas_courses/1").to route_to("diknas_courses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diknas_courses/1").to route_to("diknas_courses#destroy", :id => "1")
    end

  end
end
