class Room < ApplicationRecord
  
  has_many :chats, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
end
