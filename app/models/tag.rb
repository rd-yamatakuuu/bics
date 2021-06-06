class Tag < ApplicationRecord

  has_many :idea_tags, dependent: :destroy
end
