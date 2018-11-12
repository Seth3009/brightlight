require "rails_helper"

RSpec.describe DiknasReportCardsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diknas_report_cards").to route_to("diknas_report_cards#index")
    end

    it "routes to #new" do
      expect(:get => "/diknas_report_cards/new").to route_to("diknas_report_cards#new")
    end

    it "routes to #show" do
      expect(:get => "/diknas_report_cards/1").to route_to("diknas_report_cards#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diknas_report_cards/1/edit").to route_to("diknas_report_cards#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diknas_report_cards").to route_to("diknas_report_cards#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/diknas_report_cards/1").to route_to("diknas_report_cards#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/diknas_report_cards/1").to route_to("diknas_report_cards#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diknas_report_cards/1").to route_to("diknas_report_cards#destroy", :id => "1")
    end

  end
end
