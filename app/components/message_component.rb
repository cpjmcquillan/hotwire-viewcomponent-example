# frozen_string_literal: true

class MessageComponent < ViewComponent::Base
  include ActionView::RecordIdentifier

  def initialize(message:)
    @message = message
  end

  private

  attr_reader :message

  def classes
    %w[message-component flex flex-wrap justify-between items-center py-3 border-b-2 border-gray-300]
  end

  def html_attributes
    {id: dom_id(message)}
  end

  def body
    tag.div(message.body, class: "mr-10 text-gray-800")
  end

  def timestamp
    tag.div(message.created_at.strftime("%Y-%m-%d at %H:%M"), class: "text-gray-400")
  end
end
