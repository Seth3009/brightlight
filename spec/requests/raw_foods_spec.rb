require 'rails_helper'

RSpec.describe "RawFoods", type: :request do
  describe "GET /raw_foods" do
    it "works! (now write some real specs)" do
      get raw_foods_path
      expect(response).to have_http_status(200)
    end
  end
end
