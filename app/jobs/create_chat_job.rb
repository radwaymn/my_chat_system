class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(application_id:, chat_number:)
    Chat.create!({ application_id: application_id, number: chat_number })

    puts "Yay, chat created!"
  end
end
