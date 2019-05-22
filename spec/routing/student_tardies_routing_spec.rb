require "rails_helper"

RSpec.describe StudentTardiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/student_tardies").to route_to("student_tardies#index")
    end

    it "routes to #new" do
      expect(:get => "/student_tardies/new").to route_to("student_tardies#new")
    end

    it "routes to #show" do
      expect(:get => "/student_tardies/1").to route_to("student_tardies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/student_tardies/1/edit").to route_to("student_tardies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/student_tardies").to route_to("student_tardies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/student_tardies/1").to route_to("student_tardies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/student_tardies/1").to route_to("student_tardies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/student_tardies/1").to route_to("student_tardies#destroy", :id => "1")
    end

  end
end
