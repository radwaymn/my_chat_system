class ChatSerializer < ActiveModel::Serializer
  attributes :messages_count, :number
end

class RedisChat
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :number, :messages_count

  def initialize(attrs = {})
    attrs.each { |k, v| send("#{k}=", v) }
  end
end
