require 'rails_helper'

describe Admin do
  context '管理者ログイン' do
    it 'ログイン' do
      admin = build(:admin)
      admin.valid?
      expect(admin).to be_valid
    end
    
    it 'email validation' do
      admin = build(:admin, email: nil)
      admin.valid?
      expect(admin.errors[:email]).to include('が入力されていません。')
    end
    
    it 'password validation' do
      admin = build(:admin, password: nil)
      admin.valid?
      expect(admin.errors[:password]).to include('が入力されていません。')
    end
    
  end
end