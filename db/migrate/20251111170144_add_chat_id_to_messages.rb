class AddChatIdToMessages < ActiveRecord::Migration[8.1]
  def change
    add_reference :messages, :chat, null: false, foreign_key: true
  end
end
