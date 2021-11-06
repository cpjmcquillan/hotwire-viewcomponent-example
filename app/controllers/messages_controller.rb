class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @message = Message.create(body: params[:body])

    respond_to do |format|
      format.html { redirect_to messages_path }
      format.turbo_stream { Broadcast::Message.append(message: @message) }
    end
  end
end
