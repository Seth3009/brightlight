require 'rails_helper'

RSpec.describe "ClassBudgets", type: :request do
  describe "GET /class_budgets" do
    it "works! (now write some real specs)" do
      get class_budgets_path
      expect(response).to have_http_status(200)
    end
  end
end
