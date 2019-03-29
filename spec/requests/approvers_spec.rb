require 'rails_helper'

RSpec.describe "Approvers", type: :request do
  describe "GET /approvers" do
    it "works! (now write some real specs)" do
      get approvers_path
      expect(response).to have_http_status(200)
    end
  end
end
