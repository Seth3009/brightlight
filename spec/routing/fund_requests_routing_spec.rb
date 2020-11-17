require "rails_helper"

RSpec.describe FundRequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fund_requests").to route_to("fund_requests#index")
    end

    it "routes to #new" do
      expect(:get => "/fund_requests/new").to route_to("fund_requests#new")
    end

    it "routes to #show" do
      expect(:get => "/fund_requests/1").to route_to("fund_requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fund_requests/1/edit").to route_to("fund_requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fund_requests").to route_to("fund_requests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fund_requests/1").to route_to("fund_requests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fund_requests/1").to route_to("fund_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fund_requests/1").to route_to("fund_requests#destroy", :id => "1")
    end

  end
end
