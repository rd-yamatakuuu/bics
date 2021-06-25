require 'rails_helper'

describe ChatRoom do
  
  context 'アソシエーション' do
    
    it 'chat_room:room = N:1になっているか' do
      expect(ChatRoom.reflect_on_association(:room).macro).to eq :belongs_to
    end
    
    it 'chat_room:user = N:1になっているか' do
      expect(ChatRoom.reflect_on_association(:user).macro).to eq :belongs_to
    end
    
  end
end