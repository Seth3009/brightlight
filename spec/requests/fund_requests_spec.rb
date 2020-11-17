require 'rails_helper'

RSpec.describe "FundRequests", type: :request do
  describe "GET /fund_requests" do
    it "works! (now write some real specs)" do
      get fund_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
