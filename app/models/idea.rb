class Idea < ApplicationRecord

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :idea_tags, dependent: :destroy
  has_many :tags, through: :idea_tags
  belongs_to :user

  attachment :icon
  attachment :presentation

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

end
