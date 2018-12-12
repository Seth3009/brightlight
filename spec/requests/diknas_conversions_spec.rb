require 'rails_helper'

RSpec.describe "DiknasConversions", type: :request do
  describe "GET /diknas_conversions" do
    it "works! (now write some real specs)" do
      get diknas_conversions_path
      expect(response).to have_http_status(200)
    end
  end
end
