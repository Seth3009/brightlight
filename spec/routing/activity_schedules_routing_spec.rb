require "rails_helper"

RSpec.describe ActivitySchedulesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/activity_schedules").to route_to("activity_schedules#index")
    end

    it "routes to #new" do
      expect(:get => "/activity_schedules/new").to route_to("activity_schedules#new")
    end

    it "routes to #show" do
      expect(:get => "/activity_schedules/1").to route_to("activity_schedules#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/activity_schedules/1/edit").to route_to("activity_schedules#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/activity_schedules").to route_to("activity_schedules#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/activity_schedules/1").to route_to("activity_schedules#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/activity_schedules/1").to route_to("activity_schedules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/activity_schedules/1").to route_to("activity_schedules#destroy", :id => "1")
    end

  end
end
