require "rails_helper"

RSpec.describe NatExamsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/nat_exams").to route_to("nat_exams#index")
    end

    it "routes to #new" do
      expect(:get => "/nat_exams/new").to route_to("nat_exams#new")
    end

    it "routes to #show" do
      expect(:get => "/nat_exams/1").to route_to("nat_exams#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/nat_exams/1/edit").to route_to("nat_exams#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/nat_exams").to route_to("nat_exams#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/nat_exams/1").to route_to("nat_exams#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/nat_exams/1").to route_to("nat_exams#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/nat_exams/1").to route_to("nat_exams#destroy", :id => "1")
    end

  end
end
