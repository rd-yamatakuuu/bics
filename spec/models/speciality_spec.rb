require 'rails_helper'

describe Speciality do
  
  context 'バリデーション' do
    
    it '名前に値が入っているか' do
      speciality = build(:speciality, name: nil)
      speciality.valid?
      expect(speciality.errors[:name]).to include ('が入力されていません。')
    end
  end
  
  context 'アソシエーション' do
    
    it 'speciality:user_speciality = 1:Nになっているか' do
      expect(Speciality.reflect_on_association(:user_specialities).macro).to eq :has_many
    end
    
  end
end