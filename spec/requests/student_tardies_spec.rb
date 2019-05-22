require 'rails_helper'

RSpec.describe "StudentTardies", type: :request do
  describe "GET /student_tardies" do
    it "works! (now write some real specs)" do
      get student_tardies_path
      expect(response).to have_http_status(200)
    end
  end
end
