class MessageComponent < ViewComponent::Base
  include ActionView::RecordIdentifier

  def initialize(message:)
    @message = message
  end

  def render?
    message.persisted? && message_body.present?
  end

  private

  attr_reader :message

  delegate :body, :created_at, to: :message, prefix: true

  def classes
    %w[message-component flex flex-wrap justify-between items-center py-3 border-b-2 border-gray-300]
  end

  def html_attributes
    {id: dom_id(message)}
  end

  def body
    tag.div(message_body, class: body_class)
  end

  def body_class
    class_names("mr-10", "text-green-600" => recent_message?, "text-gray-800" => !recent_message?)
  end

  def recent_message?
    message_created_at > 1.hour.ago
  end

  def timestamp
    tag.div(message_created_at.strftime("%Y-%m-%d at %H:%M"), class: "text-gray-400")
  end
end
