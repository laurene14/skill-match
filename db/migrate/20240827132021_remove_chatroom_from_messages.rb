class RemoveChatroomFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :chatroom_id
  end
end
