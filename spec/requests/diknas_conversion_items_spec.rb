require 'rails_helper'

RSpec.describe "DiknasConversionItems", type: :request do
  describe "GET /diknas_conversion_items" do
    it "works! (now write some real specs)" do
      get diknas_conversion_items_path
      expect(response).to have_http_status(200)
    end
  end
end
