require "rails_helper"

RSpec.describe "Post message" do
  context "when the message is valid" do
    it "posts a new message to the messages page" do
      visit messages_path

      expect(page).not_to have_css("div", class: "message-component")

      fill_in "What do you want to say?", with: "This is a really important message!"

      click_on "Post message"

      expect(page).to have_css("div", class: "message-component", text: "This is a really important message!")
    end
  end

  context "when the message is invalid" do
    it "does not post a new message to the message page" do
      visit messages_path

      expect(page).not_to have_css("div", class: "message-component")

      click_on "Post message"

      expect(page).not_to have_css("div", class: "message-component")
    end
  end

  context "with turbo", js: true do
    context "when the message is valid" do
      it "posts a new message to the messages page" do
        visit messages_path

        expect(page).not_to have_css("div", class: "message-component")

        fill_in "What do you want to say?", with: "This is a really important message!"

        click_on "Post message"

        expect(page).to have_css("div", class: "message-component", text: "This is a really important message!")
      end
    end

    context "when the message is invalid" do
      it "does not post a new message to the message page" do
        visit messages_path

        expect(page).not_to have_css("div", class: "message-component")

        click_on "Post message"

        expect(page).not_to have_css("div", class: "message-component")
      end
    end
  end
end
