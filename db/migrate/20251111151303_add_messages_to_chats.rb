class AddMessagesToChats < ActiveRecord::Migration[8.1]
  def change
    add_reference :chats, :message, null: true, foreign_key: true
  end
end
