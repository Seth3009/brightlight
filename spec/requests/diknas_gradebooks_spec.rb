require 'rails_helper'

RSpec.describe "DiknasGradebooks", type: :request do
  describe "GET /diknas_gradebooks" do
    it "works! (now write some real specs)" do
      get diknas_gradebooks_path
      expect(response).to have_http_status(200)
    end
  end
end
