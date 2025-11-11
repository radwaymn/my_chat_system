class AddIndexToApplicationsToken < ActiveRecord::Migration[8.1]
  def change
    add_index :applications, :token, unique: true
  end
end
