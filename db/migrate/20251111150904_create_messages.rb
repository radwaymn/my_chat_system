class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.integer :number
      t.string :content

      t.timestamps
    end
  end
end
