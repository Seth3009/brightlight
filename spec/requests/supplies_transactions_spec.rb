require 'rails_helper'

RSpec.describe "SuppliesTransactions", type: :request do
  describe "GET /supplies_transactions" do
    it "works! (now write some real specs)" do
      get supplies_transactions_path
      expect(response).to have_http_status(200)
    end
  end
end
