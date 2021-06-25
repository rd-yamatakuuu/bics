require 'rails_helper'

describe Comment do
  context '評価' do
    it '評価値に値があるか' do
      comment = build(:comment, review: nil)
      comment.valid?
      expect(comment.errors[:review]).to include ('は数値で入力してください')
    end
  end

  context 'コメント' do
    it 'コメントの長さが100文字以内か' do
      comment = build(:comment, comment: 'a'*101)
      comment.valid?
      expect(comment.errors[:comment]).to include ('は100文字以下に設定して下さい。')
    end
  end

  context 'アソシエーション' do

    it 'comment:user = N:1か' do
      expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'comment:idea = N:1か' do
      expect(Comment.reflect_on_association(:idea).macro).to eq :belongs_to
    end
  end
end