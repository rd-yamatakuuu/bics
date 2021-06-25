require 'rails_helper'

describe Contact do
  context 'お問い合わせのバリデーション' do
    it '名前があるか' do
      contact = build(:contact, name: nil)
      contact.valid?
      expect(contact.errors[:name]).to include ('が入力されていません。')
    end
    
    it 'メールアドレスがあるか' do
      contact = build(:contact, email: nil)
      contact.valid?
      expect(contact.errors[:email]).to include ('が入力されていません。')
    end
      
    it 'メッセージがあるか' do
      contact = build(:contact, contact_message: nil)
      contact.valid?
      expect(contact.errors[:contact_message]).to include ('が入力されていません。')
    end
    
    it 'メッセージの文字数が300字以内か' do
      contact = build(:contact, contact_message: 'a'*301)
      contact.valid?
      expect(contact.errors[:contact_message]).to include ('は300文字以下に設定して下さい。')
    end
  end
  
end