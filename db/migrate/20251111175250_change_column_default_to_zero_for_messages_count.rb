class ChangeColumnDefaultToZeroForMessagesCount < ActiveRecord::Migration[8.1]
  def change
    change_column_default :chats, :messages_count, from: nil, to: 0, null: false
  end
end
