class ChangeChatIdNullOnApplications < ActiveRecord::Migration[8.1]
  def change
    change_column_null :applications, :chat_id, true
  end
end
