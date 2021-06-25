require 'rails_helper'

describe User do
  context 'registration' do
    it 'name validation' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('が入力されていません。')
    end

    it 'kana_name validation' do
      user = build(:user, kana_name: nil)
      user.valid?
      expect(user.errors[:kana_name]).to include('が入力されていません。')
    end

    it 'email validation' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('が入力されていません。', 'は有効でありません。')
    end

    it 'introduction validation' do
      user = build(:user, introduction: nil)
      user.valid?
      expect(user.errors[:introduction]).to include('が入力されていません。')
    end
    
    it 'introduction validation' do
      user = build(:user, introduction: 'a'*101)
      user.valid?
      expect(user.errors[:introduction]).to include('は100文字以下に設定して下さい。')
    end

    it 'password validation(presence)' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('が入力されていません。')
    end

    it 'password validation(letter number)' do
      user = build(:user, password: 'test')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上に設定して下さい。')
    end
  end

  context 'login' do
    it 'login' do
      user = build(:user)
      user.valid?
      expect(user).to be_valid
    end
  end
  
  context 'アソシエーション' do
    it 'user:idea = 1:Nになっている' do
      expect(User.reflect_on_association(:ideas).macro).to eq :has_many
    end
  end

end