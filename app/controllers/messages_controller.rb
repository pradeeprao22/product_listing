class MessagesController < ApplicationController
  before_action :authenticate
  
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages

    @messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)

    @messages = @conversation.messages.new
  end

  def create
    @messages = @conversation.messages.new(message_params)
    @messages.user = current_user

    if @message.save
     redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
