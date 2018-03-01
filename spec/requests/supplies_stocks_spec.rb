require 'rails_helper'

RSpec.describe "SuppliesStocks", type: :request do
  describe "GET /supplies_stocks" do
    it "works! (now write some real specs)" do
      get supplies_stocks_path
      expect(response).to have_http_status(200)
    end
  end
end
