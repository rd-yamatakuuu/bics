require 'rails_helper'

describe Notification do
  
  context 'アソシエーション' do
    
    it 'notification:idea = 1:Nになっているか' do
      expect(Notification.reflect_on_association(:idea).macro).to eq :belongs_to
    end
    
    it 'notification:comment = 1:Nになっているか' do
      expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
    end
    
    it 'notification:chat = 1:Nになっているか' do
      expect(Notification.reflect_on_association(:chat).macro).to eq :belongs_to
    end
    
    it 'notification:room = 1:Nになっているか' do
      expect(Notification.reflect_on_association(:room).macro).to eq :belongs_to
    end
    
    it 'notification:visitor = 1:Nになっているか' do
      expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
    end
    
    it 'notification:visited = 1:Nになっているか' do
      expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
    end
  end
end