require "rails_helper"

RSpec.describe ApproversController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/approvers").to route_to("approvers#index")
    end

    it "routes to #new" do
      expect(:get => "/approvers/new").to route_to("approvers#new")
    end

    it "routes to #show" do
      expect(:get => "/approvers/1").to route_to("approvers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/approvers/1/edit").to route_to("approvers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/approvers").to route_to("approvers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/approvers/1").to route_to("approvers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/approvers/1").to route_to("approvers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/approvers/1").to route_to("approvers#destroy", :id => "1")
    end

  end
end
