class Api::V1::MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat

  def index
    # messages = params[:search].present? ? @chat.messages.search(params[:search]) : @chat.messages.limit(limit).offset(params[:page])
    # render json: messages
    db_messages = params[:search].present? ? @chat.messages.search(params[:search]) : @chat.messages.limit(limit).offset(params[:page])

    redis_key = "chat:#{@chat.id}:messages_buffer"
    redis_raw = REDIS.lrange(redis_key, 0, -1)

    redis_messages = redis_raw.map do |r|
      RedisMessage.new(JSON.parse(r))
    end

    combined = db_messages  + redis_messages

    render json: combined, each_serializer: MessageSerializer, status: :ok
  end

  def search
    messages = @chat.messages.search(params[:search])
    render json: messages
  end

  def create
    message_number = set_next_number

    # CreateMessageJob.perform_later(
    #   chat_id: @chat.id, message_number: message_number, content: message_params[:content]
    # )

    REDIS.rpush(
      "chat:#{@chat.id}:messages_buffer",
      { number: message_number, content: message_params[:content] }.to_json
    )

    render json: { number: message_number }, status: :accepted
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

  def set_next_number
    key = "application:#{@application.id}:chat_number:#{@chat.id}:message_number"
    REDIS.setnx(key, (@chat.messages.maximum(:number) || 0))
    REDIS.incr(key)
  end
end
