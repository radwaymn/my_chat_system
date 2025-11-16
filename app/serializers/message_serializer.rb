class MessageSerializer < ActiveModel::Serializer
  attributes :content, :number
end

class RedisMessage
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :number, :content

  def initialize(attrs = {})
    attrs.each { |k, v| send("#{k}=", v) }
  end
end
