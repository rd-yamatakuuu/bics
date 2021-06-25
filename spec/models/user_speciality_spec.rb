describe UserSpeciality do
  
  context 'アソシエーション' do
    
    it 'user_speciality:speciality = N:1になっているか' do
      expect(UserSpeciality.reflect_on_association(:speciality).macro).to eq :belongs_to
    end
    
    it 'user_speciality:user = N:1になっているか' do
      expect(UserSpeciality.reflect_on_association(:user).macro).to eq :belongs_to
    end
    
  end
end