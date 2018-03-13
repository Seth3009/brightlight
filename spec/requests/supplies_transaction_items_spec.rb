require 'rails_helper'

RSpec.describe "SuppliesTransactionItems", type: :request do
  describe "GET /supplies_transaction_items" do
    it "works! (now write some real specs)" do
      get supplies_transaction_items_path
      expect(response).to have_http_status(200)
    end
  end
end
