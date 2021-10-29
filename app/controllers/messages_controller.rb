class MessagesController < ApplicationController
  def create
    @message = Message.create(message_params)

    respond_to do |format|
      format.html { redirect_to messages_path }
      format.turbo_stream do
        if @message.persisted?
          Broadcast::Message.append(message: @message)
        end
      end
    end
  end

  private

  helper_method :messages, :new_message

  def messages
    @messages ||= Message.all
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def new_message
    @new_message ||= Message.new
  end
end
