class FlushMessagesJob < ApplicationJob
  queue_as :default

  def perform
    Chat.find_each do |chat|
      flush_chat_messages(chat.id)
    end
  end

  private

  def flush_chat_messages(chat_id)
    key = "chat:#{chat_id}:messages_buffer"
    batch = []

    # pop messages until queue is empty
    while (json = REDIS.lpop(key))
      batch << JSON.parse(json).merge({ chat_id: chat_id })
    end

    return if batch.empty?

    # Bulk insert in DB
    Message.insert_all(batch)
    Chat.reset_counters(chat_id, :messages)

    puts "Inserted #{batch.size} messages to chat #{chat_id}"
  end
end
