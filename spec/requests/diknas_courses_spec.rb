require 'rails_helper'

RSpec.describe "DiknasCourses", type: :request do
  describe "GET /diknas_courses" do
    it "works! (now write some real specs)" do
      get diknas_courses_path
      expect(response).to have_http_status(200)
    end
  end
end
