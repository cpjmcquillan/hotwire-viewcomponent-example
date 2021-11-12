require "rails_helper"

RSpec.describe Broadcast::Message, type: :model do
  include ActionView::TestCase::Behavior

  describe ".append" do
    it "broadcasts the message" do
      turbo_stream_broadcast = stub_turbo_stream_broadcast
      message = Message.create!(body: "A special message")
      rendered_component = MessageComponent.new(message: message).render_in(view)

      Broadcast::Message.append(message: message)

      expect(turbo_stream_broadcast).to have_received(:broadcast_append_later_to).with(
        :messages,
        target: "messages",
        html: rendered_component
      )
    end
  end

  def stub_turbo_stream_broadcast
    allow(Turbo::StreamsChannel).to receive(:broadcast_append_later_to)
    Turbo::StreamsChannel
  end
end
