class Idea < ApplicationRecord

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :idea_tags, dependent: :destroy
  belongs_to :user

  attachment :icon
  attachment :presentation

end
