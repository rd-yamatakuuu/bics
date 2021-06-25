require 'rails_helper'

describe Room do
  
  context 'アソシエーション' do
    
    it 'room:chat = 1:Nになっているか' do
      expect(Room.reflect_on_association(:chats).macro).to eq :has_many
    end
    
    it 'room:chat_room = 1:Nになっているか' do
      expect(Room.reflect_on_association(:chat_rooms).macro).to eq :has_many
    end
    
    it 'room:user = 1:Nになっているか' do
      expect(Room.reflect_on_association(:user).macro).to eq :belongs_to
    end
    
    it 'room:notification = 1:Nになっているか' do
      expect(Room.reflect_on_association(:notifications).macro).to eq :has_many
    end
  end
end