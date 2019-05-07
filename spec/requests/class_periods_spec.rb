require 'rails_helper'

RSpec.describe "ClassPeriods", type: :request do
  describe "GET /class_periods" do
    it "works! (now write some real specs)" do
      get class_periods_path
      expect(response).to have_http_status(200)
    end
  end
end
