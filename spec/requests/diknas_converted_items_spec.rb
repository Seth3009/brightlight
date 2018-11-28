require 'rails_helper'

RSpec.describe "DiknasConvertedItems", type: :request do
  describe "GET /diknas_converted_items" do
    it "works! (now write some real specs)" do
      get diknas_converted_items_path
      expect(response).to have_http_status(200)
    end
  end
end
