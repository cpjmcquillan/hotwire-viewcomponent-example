require "rails_helper"

RSpec.describe "Viewing messages" do
  context "when there are no messages to display" do
    it "displays a helpful message" do
      visit messages_path

      expect(page).to have_content "There are no messages to display"
    end
  end

  context "when there are messages to display" do
    it "displays messages" do
      create_messages(2)

      visit messages_path

      expect(page).to have_css("div", class: "message-component", count: 2)
    end
  end

  def create_messages(message_count)
    message_count.times { Message.create(body: "some content") }
  end
end
