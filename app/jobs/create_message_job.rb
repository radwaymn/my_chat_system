class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_id:, message_number:, content:)
    Message.create!({ chat_id: chat_id, number: message_number, content: content })

    puts "Yay, message created!"
  end
end
