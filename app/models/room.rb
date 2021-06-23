class Room < ApplicationRecord

  has_many :chats
  has_many :chat_rooms
  belongs_to :user, optional: true
  has_many :notifications, dependent: :destroy

  def create_notification_chat!(current_user, chat_id)

    visited_datas = ChatRoom.select(:user_id).where(room_id: id).where.not(user_id: current_user.id).distinct
    
    visited_datas.each do |visited_data|
      save_notification_chat!(current_user, chat_id, visited_data.user_id)
    end

    #save_notification_chat!(current_user, chat_id, user_id) if tmp_ids.blank?
  end


  def save_notification_chat!(current_user, chat_id, visited_id)
    notification = current_user.active_notifications.new(room_id: id, chat_id: chat_id, visited_id: visited_id, action: 'chat')

    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save
  end

end
