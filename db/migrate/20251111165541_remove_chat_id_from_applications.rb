class RemoveChatIdFromApplications < ActiveRecord::Migration[8.1]
  def change
    remove_column :applications, :chat_id, :bigint
  end
end
