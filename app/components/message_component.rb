# frozen_string_literal: true

class MessageComponent < ViewComponent::Base
  def initialize(message:)
    @message = message
  end

  private

  attr_reader :message

  def timestamp
    message.created_at.strftime("posted on %Y-%m-%d at %H:%M")
  end
end
