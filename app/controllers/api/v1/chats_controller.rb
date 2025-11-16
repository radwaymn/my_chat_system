class Api::V1::ChatsController < ApplicationController
  before_action :set_application

  def index
    chats = @application.chats.limit(limit).offset(params[:page])
    render json: chats
  end

  def create
    chat_number = set_next_number

    CreateChatJob.perform_later(
      application_id: @application.id,
      chat_number: chat_number
    )

    render json: { number: chat_number }, status: :accepted
  end

  private

  def set_application
    @application = Application.find_by!(token: params[:application_token])
  end

  def set_next_number
    key = "application:#{@application.id}:chat_number"
    REDIS.setnx(key, (@application.chats.maximum(:number) || 0))
    REDIS.incr(key)
  end
end
