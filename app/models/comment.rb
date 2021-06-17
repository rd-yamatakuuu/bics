class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :idea
  
  validates :review, numericality: {greter_than: 0 }
  
end
