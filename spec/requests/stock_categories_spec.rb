require 'rails_helper'

RSpec.describe "StockCategories", type: :request do
  describe "GET /stock_categories" do
    it "works! (now write some real specs)" do
      get stock_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
