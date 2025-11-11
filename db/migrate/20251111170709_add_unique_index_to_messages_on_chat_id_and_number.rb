class AddUniqueIndexToMessagesOnChatIdAndNumber < ActiveRecord::Migration[8.1]
  def change
    add_index :messages, [ :chat_id, :number ], unique: true
  end
end
