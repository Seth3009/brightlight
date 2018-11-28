require 'rails_helper'

RSpec.describe "DiknasReportConverteds", type: :request do
  describe "GET /diknas_report_converteds" do
    it "works! (now write some real specs)" do
      get diknas_report_converteds_path
      expect(response).to have_http_status(200)
    end
  end
end
