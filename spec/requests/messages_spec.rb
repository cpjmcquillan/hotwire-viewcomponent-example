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
      it "does not create or broadcast the message, and redirects to the messages_path" do
        message_broadcast = stub_message_broadcast
        post messages_path, params: {body: ""}

        expect(Message.count).to be_zero
        expect(message_broadcast).not_to have_received(:append)
        expect(response).to redirect_to(messages_path)
      end
    end

    context "when the message body contains content" do
      it "creates and broadcasts the message, and redirects to the messages_path" do
        message_broadcast = stub_message_broadcast
        post messages_path, params: {body: "A new message!"}

        expect(Message.count).to eq 1
        expect(message_broadcast).to have_received(:append).with(message: Message.last)
        expect(response).to redirect_to(messages_path)
      end
    end
  end

  def stub_message_broadcast
    allow(Broadcast::Message).to receive(:append)
    Broadcast::Message
  end
end
