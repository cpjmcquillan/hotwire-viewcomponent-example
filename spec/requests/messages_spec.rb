require "rails_helper"

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get messages_path
      expect(response).to have_http_status(:success)
    end
  end
end
