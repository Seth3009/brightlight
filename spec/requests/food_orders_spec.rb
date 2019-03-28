require 'rails_helper'

RSpec.describe "FoodOrders", type: :request do
  describe "GET /food_orders" do
    it "works! (now write some real specs)" do
      get food_orders_path
      expect(response).to have_http_status(200)
    end
  end
end
