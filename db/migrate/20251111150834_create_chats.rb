class CreateChats < ActiveRecord::Migration[8.1]
  def change
    create_table :chats do |t|
      t.integer :number
      t.integer :messages_count

      t.timestamps
    end
  end
end
