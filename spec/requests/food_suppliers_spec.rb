require 'rails_helper'

RSpec.describe "FoodSuppliers", type: :request do
  describe "GET /food_suppliers" do
    it "works! (now write some real specs)" do
      get food_suppliers_path
      expect(response).to have_http_status(200)
    end
  end
end
