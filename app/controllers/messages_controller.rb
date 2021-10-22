class MessagesController < ApplicationController
  def index
    @new_message = Message.new
  end

  def create
    Message.create(message_params)

    redirect_to messages_path
  end

  private

  helper_method :messages

  def messages
    @messages ||= Message.all
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
