class Public::ChatsController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    rooms = current_user.chat_rooms.pluck(:room_id)
    chat_rooms= ChatRoom.find_by(user_id: @user.id, room_id: rooms)

    if chat_rooms.nil?
      @room = Room.new
      @room.save
      ChatRoom.create(user_id: current_user.id, room_id: @room.id)
      ChatRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = chat_rooms.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @room = @chat.room
    @chat.save
    @room.create_notification_chat!(current_user, @chat.id)
    redirect_to request.referer
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
