require 'rails_helper'

RSpec.describe "LunchMenus", type: :request do
  describe "GET /lunch_menus" do
    it "works! (now write some real specs)" do
      get lunch_menus_path
      expect(response).to have_http_status(200)
    end
  end
end
