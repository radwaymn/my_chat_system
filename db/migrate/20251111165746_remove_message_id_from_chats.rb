class RemoveMessageIdFromChats < ActiveRecord::Migration[8.1]
  def change
    remove_column :chats, :message_id, :bigint
  end
end
