module Broadcast
  class Message
    def self.append(message:)
      new(message).append
    end

    def initialize(message)
      @message = message
      @view_context = ApplicationController.new.view_context
    end

    def append
      Turbo::StreamsChannel.broadcast_append_later_to(
        :messages,
        target: "messages",
        html: rendered_component
      )
    end

    private

    attr_reader :message, :view_context

    def rendered_component
      MessageComponent.new(message: message).render_in(view_context)
    end
  end
end
