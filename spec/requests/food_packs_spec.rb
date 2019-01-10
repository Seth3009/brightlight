require 'rails_helper'

RSpec.describe "FoodPacks", type: :request do
  describe "GET /food_packs" do
    it "works! (now write some real specs)" do
      get food_packs_path
      expect(response).to have_http_status(200)
    end
  end
end
