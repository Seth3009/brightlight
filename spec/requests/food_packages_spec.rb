require 'rails_helper'

RSpec.describe "FoodPackages", type: :request do
  describe "GET /food_packages" do
    it "works! (now write some real specs)" do
      get food_packages_path
      expect(response).to have_http_status(200)
    end
  end
end
