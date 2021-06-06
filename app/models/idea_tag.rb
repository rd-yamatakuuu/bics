class IdeaTag < ApplicationRecord
  
  belongs_to :idea
  belongs_to :tag
end
