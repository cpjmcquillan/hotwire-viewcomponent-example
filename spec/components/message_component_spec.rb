require "rails_helper"

RSpec.describe MessageComponent, type: :component do
  it "renders the component with correct id" do
    body = "This is a wonderful and pleasant message."
    message = Message.create(body: body)
    component = MessageComponent.new(message: message)

    render_inline(component)

    expect(rendered_component).to have_css("div", class: %w[message-component], id: "message_#{message.id}")
  end

  it "renders the body" do
    body = "This is a wonderful and pleasant message."
    message = Message.create(body: body)
    component = MessageComponent.new(message: message)

    render_inline(component)

    expect(rendered_component).to have_css("div", class: %w[message-component], text: body)
  end

  it "renders the timestamp" do
    freeze_time do
      body = "This is a wonderful and pleasant message."
      message = Message.create(body: body)
      component = MessageComponent.new(message: message)

      render_inline(component)

      timestamp = Time.current.strftime("%Y-%m-%d at %H:%M")
      expect(rendered_component).to have_css("div", class: %w[message-component], text: timestamp)
    end
  end
end
