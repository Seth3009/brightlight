require 'rails_helper'

RSpec.describe "DiknasReportCards", type: :request do
  describe "GET /diknas_report_cards" do
    it "works! (now write some real specs)" do
      get diknas_report_cards_path
      expect(response).to have_http_status(200)
    end
  end
end
