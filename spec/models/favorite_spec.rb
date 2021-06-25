describe Favorite do
  
  context 'アソシエーション' do
    
    it 'favorite:idea = N:1になっているか' do
      expect(Favorite.reflect_on_association(:idea).macro).to eq :belongs_to
    end
    
    it 'favorite:user = N:1になっているか' do
      expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
    end
    
  end
    
end