require 'rails_helper'

describe Idea do

  context 'アイデアのバリデーション' do

    it 'タイトルに値があるか' do
      idea = build(:idea, title: nil)
      idea.valid?
      expect(idea.errors[:title]).to include ('が入力されていません。')
    end

    it '内容に値があるか' do
      idea = build(:idea, content: nil)
      idea.valid?
      expect(idea.errors[:content]).to include ('が入力されていません。')
    end

    it '内容の文字数が500以下か' do
      idea = build(:idea, content: 'a' * 501)
      idea.valid?
      expect(idea.errors[:content]).to include ('は500文字以下に設定して下さい。')
    end

  end

  context 'アソシエーション' do

    it 'idea:favorite = 1:Nか' do
      expect(Idea.reflect_on_association(:favorites).macro).to eq :has_many
    end

    it 'idea:comment = 1:Nか' do
      expect(Idea.reflect_on_association(:comments).macro).to eq :has_many
    end

    it 'idea:tag = 1:Nか' do
      expect(Idea.reflect_on_association(:tags).macro).to eq :has_many
    end

    it 'idea:idea_tag = 1:Nか' do
      expect(Idea.reflect_on_association(:idea_tags).macro).to eq :has_many
    end

    it 'idea:notification = 1:Nか' do
      expect(Idea.reflect_on_association(:notifications).macro).to eq :has_many
    end

    it 'idea:user = N:1か' do
      expect(Idea.reflect_on_association(:user).macro).to eq :belongs_to
    end

  end
end