require 'rails_helper'

RSpec.describe "DiknasReportConvertedItems", type: :request do
  describe "GET /diknas_report_converted_items" do
    it "works! (now write some real specs)" do
      get diknas_report_converted_items_path
      expect(response).to have_http_status(200)
    end
  end
end
