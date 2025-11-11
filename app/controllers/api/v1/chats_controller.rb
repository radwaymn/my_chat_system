class Api::V1::ChatsController < ApplicationController
  before_action :set_application

  def index
    chats = @application.chats.limit(limit).offset(params[:page])
    render json: chats
  end

  def create
    chat = Chat.new(application_id: @application.id)

    if chat.save
      render json: chat, status: :created
    else
      render json: chat.errors, status: :unprocessable_entity
    end
  end

  private

  def set_application
    @application = Application.find_by!(token: params[:application_token])
  end
end
