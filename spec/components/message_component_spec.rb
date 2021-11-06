require "rails_helper"

RSpec.describe MessageComponent, type: :component do
  context "when the message is not persisted" do
    it "does not render the component" do
      body = "This is a wonderful and pleasant message."
      message = Message.new(body: body)
      component = MessageComponent.new(message: message)

      render_inline(component)

      expect(rendered_component).to be_blank
    end
  end

  context "when the message body is blank" do
    it "does not render the component" do
      message = Message.new(body: "")
      message.save(validate: false)
      component = MessageComponent.new(message: message)

      render_inline(component)

      expect(rendered_component).to be_blank
    end
  end

  it "renders a component with the correct id" do
    body = "This is a wonderful and pleasant message."
    message = Message.create(body: body)
    component = MessageComponent.new(message: message)

    render_inline(component)

    expect(rendered_component).to have_css("div", class: %w[message-component], id: "message_#{message.id}")
  end

  context "when the message is recent" do
    it "renders the body in green" do
      body = "This is a wonderful and pleasant message."
      message = Message.create(body: body)
      component = MessageComponent.new(message: message)

      render_inline(component)

      expect(rendered_component).to have_css("div.message-component > div", class: %w[text-green-600], text: body)
    end
  end

  context "when the message is not recent" do
    it "renders the body in gray" do
      body = "This is a wonderful and pleasant message."
      message = Message.create(body: body, created_at: 2.hours.ago)
      component = MessageComponent.new(message: message)

      render_inline(component)

      expect(rendered_component).to have_css("div.message-component > div", class: %w[text-gray-800], text: body)
    end
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
