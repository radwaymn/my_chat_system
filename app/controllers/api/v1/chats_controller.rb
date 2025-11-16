class Api::V1::ChatsController < ApplicationController
  before_action :set_application

  def index
    # chats = @application.chats.limit(limit).offset(params[:page])
    # render json: chats
    db_chats = @application.chats.limit(limit).offset(params[:page])

    redis_key = "application:#{@application.id}:chats_buffer"
    redis_raw = REDIS.lrange(redis_key, 0, -1)

    redis_chats = redis_raw.map do |r|
      RedisChat.new(JSON.parse(r).merge({ messages_count: 0 }))
    end

    combined = db_chats  + redis_chats

    render json: combined, each_serializer: ChatSerializer, status: :ok
  end

  def create
    chat_number = set_next_number

    # CreateChatJob.perform_later(
    #   application_id: @application.id,
    #   chat_number: chat_number
    # )

    REDIS.rpush(
      "application:#{@application.id}:chats_buffer",
      { number: chat_number }.to_json
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
