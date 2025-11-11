class AddChatsToApplications < ActiveRecord::Migration[8.1]
  def change
    add_reference :applications, :chat, null: true, foreign_key: true
  end
end
