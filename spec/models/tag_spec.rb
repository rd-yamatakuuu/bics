require 'rails_helper'

describe Tag do
  
  context 'バリデーション' do
    
    it '名前に値が入っているか' do
      tag = build(:tag, tag_name: nil)
      tag.valid?
      expect(tag.errors[:tag_name]).to include ('が入力されていません。')
    end
  end
  
  context 'アソシエーション' do
    
    it 'tag:idea_tag = 1:Nになっているか' do
      expect(Tag.reflect_on_association(:idea_tags).macro).to eq :has_many
    end
    
    it 'tag:idea = 1:Nになっているか(中間テーブルを介して)' do
      expect(Tag.reflect_on_association(:ideas).macro).to eq :has_many
    end
    
  end
end