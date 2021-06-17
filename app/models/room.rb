class Room < ApplicationRecord

  has_many :chats
  has_many :chat_rooms
end
