class Idea < ApplicationRecord

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :idea_tags, dependent: :destroy
  has_many :tags, through: :idea_tags
  has_many :notifications, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 500}

  attachment :icon
  attachment :presentation, extension: 'pdf'

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

  #検索
  def self.looks(references, words)
    if references == 'perfect_match'
      @idea = Idea.where('title LIKE ?', "#{words}")
    else
      @idea = Idea.where('title LIKE ?', "%#{words}%")
    end
  end
  
  #通知モデル
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(idea_id: id, visited_id: user_id, action:'favorite')
    notification.save if notification.valid?
  end
  
  def create_notification_comment!(current_user, comment_id)
    tmp_ids = Comment.select(:user_id).where(idea_id: id).where.not(user_id: current_user.id).distinct
    
    tmp_ids.each do |tmp_id|
      save_notification_comment!(current_user, comment_id, tmp_id['user_id'])
    end
    
    save_notification_comment!(current_user, comment_id, user_id) if tmp_ids.blank?
  end
  
  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(idea_id: id, comment_id: comment_id, visited_id: visited_id, action: 'comment')
    
    if notification.visitor_id == notification.visited_id
      notification.checked == true
    end
    
    notification.save if notification.valid?
  end

end
