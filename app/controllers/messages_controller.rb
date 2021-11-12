class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @message = Message.new(body: params[:body])

    if @message.save
      Broadcast::Message.append(message: @message)
    end

    respond_to do |format|
      format.html { redirect_to messages_path }
      format.turbo_stream
    end
  end
end
