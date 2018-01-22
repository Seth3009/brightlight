require 'rails_helper'

RSpec.describe "ItemUnits", type: :request do
  describe "GET /item_units" do
    it "works! (now write some real specs)" do
      get item_units_path
      expect(response).to have_http_status(200)
    end
  end
end
