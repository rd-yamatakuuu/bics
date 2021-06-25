describe IdeaTag do
  
  context 'アソシエーション' do
    
    it 'idea_tag:tag = N:1になっているか' do
      expect(IdeaTag.reflect_on_association(:tag).macro).to eq :belongs_to
    end
    
    it 'idea_tag:idea = N:1になっているか' do
      expect(IdeaTag.reflect_on_association(:idea).macro).to eq :belongs_to
    end
    
  end
end