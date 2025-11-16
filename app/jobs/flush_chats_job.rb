class FlushChatsJob < ApplicationJob
  queue_as :default

  def perform
    Application.find_each do |app|
      flush_app_chats(app.id)
    end
  end

  private

  def flush_app_chats(app_id)
    key = "application:#{app_id}:chats_buffer"
    batch = []

    # pop chats until queue is empty
    while (json = REDIS.lpop(key))
      batch << JSON.parse(json).merge({ application_id: app_id })
    end

    return if batch.empty?

    # Bulk insert in DB
    Chat.insert_all(batch)
    Application.reset_counters(app_id, :chats)

    puts "Inserted #{batch.size} chats to application #{app_id}"
  end
end
