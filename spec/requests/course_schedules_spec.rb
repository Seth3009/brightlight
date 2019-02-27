require 'rails_helper'

RSpec.describe "CourseSchedules", type: :request do
  describe "GET /course_schedules" do
    it "works! (now write some real specs)" do
      get course_schedules_path
      expect(response).to have_http_status(200)
    end
  end
end
