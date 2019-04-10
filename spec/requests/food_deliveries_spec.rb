require 'rails_helper'

RSpec.describe "FoodDeliveries", type: :request do
  describe "GET /food_deliveries" do
    it "works! (now write some real specs)" do
      get food_deliveries_path
      expect(response).to have_http_status(200)
    end
  end
end
