class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :idea
  
  validates :review, numericality: {greter_than: 0 }
  validates :comment, length: {maximum: 100}
end
