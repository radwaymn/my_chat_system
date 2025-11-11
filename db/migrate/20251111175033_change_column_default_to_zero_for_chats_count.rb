class ChangeColumnDefaultToZeroForChatsCount < ActiveRecord::Migration[8.1]
  def change
    change_column_default :applications, :chats_count, from: nil, to: 0, null: false
  end
end
