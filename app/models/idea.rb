class Idea < ApplicationRecord

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :idea_tags, dependent: :destroy
  has_many :tags, through: :idea_tags
  belongs_to :user

  validates :review, numericality: {greter_than: 0 }

  attachment :icon
  attachment :presentation

  #タグ付け用の関数
  def save_tags(idea_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - idea_tags
    new_tags = idea_tags - current_tags

    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(tag_name: old_tag)
    end

    new_tags.each do |new_tag|
      tag = Tag.find_or_create_by(tag_name: new_tag)
      self.tags << tag
    end
  end

  #いいね確認関数
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #reviewのindexページ分（平均値）
  def review_index(comment)
    arr = []
    comment.each do |idea|
      arr << idea.review
    end
    arr.sum.fdiv(arr.length).round(1)
  end

  #グラフ生成
  def chart_review_value(reviews)
    arr1 = []
    reviews.each do |comment|
      arr1 << comment.review
    end
    arr1 = arr1.sort.reverse
    arr2 = []
    arr2 << arr1.group_by(&:itself).map{ |k, v| [k, v.count] }.to_h
    x = arr2[0]
    y = x.values
    y
  end

  def chart_review_key(reviews)
    arr1 = []
    reviews.each do |comment|
      arr1 << comment.review
    end
    arr1 = arr1.sort.reverse
    arr2 = []
    arr2 << arr1.group_by(&:itself).map{ |k, v| [k, v.count] }.to_h
    x = arr2[0]
    y = x.keys
    y
  end

end
