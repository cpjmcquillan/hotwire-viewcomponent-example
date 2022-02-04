module Broadcast
  class Message
    def self.append(message:)
      new(message).append
    end

    def initialize(message)
      @message = message
    end

    def append
      Turbo::StreamsChannel.broadcast_append_later_to(
        :messages,
        target: "messages",
        html: rendered_component
      )
    end

    private

    attr_reader :message

    def rendered_component
      ApplicationController.render(
        MessageComponent.new(message: message),
        layout: false
      )
    end
  end
end
