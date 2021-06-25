require 'rails_helper'

describe Relationship do
  
  context 'アソシエーション' do
    
    it 'user:follower = 1:Nになっているか' do
      expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
    end
    
    it 'user:followed = 1:Nになっているか' do
      expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
    end
    
  end
end