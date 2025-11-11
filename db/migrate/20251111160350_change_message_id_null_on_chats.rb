class ChangeMessageIdNullOnChats < ActiveRecord::Migration[8.1]
  def change
    change_column_null :chats, :message_id, true
  end
end
