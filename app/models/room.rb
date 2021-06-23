class Room < ApplicationRecord

  has_many :chats
  has_many :chat_rooms
  belongs_to :user, optional: true
  has_many :notifications, dependent: :destroy

  def create_notification_chat!(current_user, chat_id)

    tmp_ids = ChatRoom.select(:user_id).where(room_id: id).where.not(user_id: current_user.id).distinct
    tmp_ids.each do |tmp_id|
      save_notification_chat!(current_user, chat_id, tmp_id['user_id'])
    end

    #save_notification_chat!(current_user, chat_id, user_id) if tmp_ids.blank?
  end


  def save_notification_chat!(current_user, chat_id, visited_id)
    notification = current_user.active_notifications.new(room_id: id, chat_id: chat_id, visited_id: visited_id, action: 'chat')

    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
