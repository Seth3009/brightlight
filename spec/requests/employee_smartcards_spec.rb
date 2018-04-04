require 'rails_helper'

RSpec.describe "EmployeeSmartcards", type: :request do
  describe "GET /employee_smartcards" do
    it "works! (now write some real specs)" do
      get employee_smartcards_path
      expect(response).to have_http_status(200)
    end
  end
end
