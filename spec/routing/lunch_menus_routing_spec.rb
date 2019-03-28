require "rails_helper"

RSpec.describe LunchMenusController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/lunch_menus").to route_to("lunch_menus#index")
    end

    it "routes to #new" do
      expect(:get => "/lunch_menus/new").to route_to("lunch_menus#new")
    end

    it "routes to #show" do
      expect(:get => "/lunch_menus/1").to route_to("lunch_menus#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/lunch_menus/1/edit").to route_to("lunch_menus#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/lunch_menus").to route_to("lunch_menus#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/lunch_menus/1").to route_to("lunch_menus#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/lunch_menus/1").to route_to("lunch_menus#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/lunch_menus/1").to route_to("lunch_menus#destroy", :id => "1")
    end

  end
end
