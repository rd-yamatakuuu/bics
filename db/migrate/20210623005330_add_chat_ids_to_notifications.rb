class AddChatIdsToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :chat_id, :integer
  end
end
