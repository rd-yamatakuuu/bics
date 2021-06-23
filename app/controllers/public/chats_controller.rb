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
    
    @tmp_room = ChatRoom.find_by(user_id: current_user.id)
    # @another_room = ChatRoom.where(room_id: @tmp_room.room_id).where.not(user_id: current_user.id)
    @another_room = ChatRoom.find_by(room_id: @tmp_room.room_id, user_id: !current_user.id)
    @another_room2 = ChatRoom.find_by(room_id: @tmp_room.room_id, user_id: current_user.id)
    @room3 = ChatRoom.find_by(room_id: @tmp_room.room_id)
    @room4 = ChatRoom.where(room_id: @tmp_room.room_id).where.not(user_id: current_user.id)
    @room5 = ChatRoom.where(room_id: @tmp_room.room_id)
    @room6 = @room5.find_by(user_id: !current_user.id)
    @room7 = @room5.find_by(user_id: current_user.id)
    
    @chat = current_user.chats.new(chat_params)
    @chat.save
    @chat.user.create_notification_chat!(current_user, @chat.id)
    redirect_to request.referer
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
