class Api::V1::MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat

  def index
    messages = @chat.messages.limit(limit).offset(params[:page])
    render json: messages
  end

  def create
    # Use a service or transaction to safely increment per-chat number
    message = nil

    @chat.with_lock do
      message = @chat.messages.new(message_params)

      if message.save
        render json: message, status: :created
      else
        render json: { errors: message.errors }, status: :unprocessable_entity
      end
    end
  end



  def update
    message = @chat.messages.find_by!(number: params[:number])
      if message.update(message_params)
        render json: message, status: :ok
      else
        render json: message.errors, status: :unprocessable_entity
      end
  end


  private

  def set_application
    @application = Application.find_by!(token: params[:application_token])
  end

  def set_chat
    @chat = @application.chats.find_by!(number: params[:chat_number])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
