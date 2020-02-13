require 'rails_helper'

RSpec.describe "NatExams", type: :request do
  describe "GET /nat_exams" do
    it "works! (now write some real specs)" do
      get nat_exams_path
      expect(response).to have_http_status(200)
    end
  end
end
