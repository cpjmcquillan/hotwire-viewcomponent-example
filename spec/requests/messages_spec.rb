require "rails_helper"

RSpec.describe "Messages", type: :request do
  describe "GET #index" do
    it "returns http success" do
      get messages_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "when the message body is blank" do
      it "does not create the message and redirects to the messages_path" do
        post messages_path, params: {message: {body: ""}}

        expect(Message.count).to be_zero
        expect(response).to redirect_to(messages_path)
      end
    end

    context "when the message body contains content" do
      it "creates the message and redirects to the messages_path" do
        post messages_path, params: {message: {body: "A new message!"}}

        expect(Message.count).to eq 1
        expect(response).to redirect_to(messages_path)
      end
    end
  end
end
