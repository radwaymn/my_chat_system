class AddApplicationIdToChats < ActiveRecord::Migration[8.1]
  def change
    add_reference :chats, :application, null: false, foreign_key: true
  end
end
