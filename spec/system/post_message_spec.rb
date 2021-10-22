require "rails_helper"

RSpec.describe "Post message" do
  it "posts a new message to the messages page" do
    visit messages_path

    expect(page).not_to have_css("div", class: "message-component")

    fill_in "What do you want to say?", with: "This is a really important message!"

    click_on "Post message"

    expect(page).to have_css("div", class: "message-component", text: "This is a really important message!")
  end
end
