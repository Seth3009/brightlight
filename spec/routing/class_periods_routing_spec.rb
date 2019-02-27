require "rails_helper"

RSpec.describe ClassPeriodsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/class_periods").to route_to("class_periods#index")
    end

    it "routes to #new" do
      expect(:get => "/class_periods/new").to route_to("class_periods#new")
    end

    it "routes to #show" do
      expect(:get => "/class_periods/1").to route_to("class_periods#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/class_periods/1/edit").to route_to("class_periods#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/class_periods").to route_to("class_periods#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/class_periods/1").to route_to("class_periods#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/class_periods/1").to route_to("class_periods#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/class_periods/1").to route_to("class_periods#destroy", :id => "1")
    end

  end
end
