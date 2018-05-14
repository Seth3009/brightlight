require 'rails_helper'

RSpec.describe "ActivitySchedules", type: :request do
  describe "GET /activity_schedules" do
    it "works! (now write some real specs)" do
      get activity_schedules_path
      expect(response).to have_http_status(200)
    end
  end
end
