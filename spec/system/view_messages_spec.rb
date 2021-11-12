require "rails_helper"

RSpec.describe "Viewing messages" do
  it "displays messages" do
    create_messages(2)

    visit messages_path

    expect(page).to have_css("div", class: "message-component", count: 2)
  end

  context "with turbo", js: true do
    context "when a different user posts a message" do
      it "displays the new message" do
        visit messages_path

        message = Message.create!(body: "This message is broadcast!")
        broadcast_message(message)

        expect(page).to have_css("div", class: "message-component", text: "This message is broadcast!")
      end
    end
  end

  def create_messages(message_count)
    message_count.times { Message.create!(body: "some content") }
  end

  def broadcast_message(message)
    Broadcast::Message.append(message: message)
  end
end
