require 'rails_helper'

RSpec.describe "DiknasConverteds", type: :request do
  describe "GET /diknas_converteds" do
    it "works! (now write some real specs)" do
      get diknas_converteds_path
      expect(response).to have_http_status(200)
    end
  end
end
