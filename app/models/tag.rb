class Tag < ApplicationRecord

  has_many :idea_tags, dependent: :destroy
  has_many :ideas, through: :idea_tags
  
  validates :tag_name, uniqueness: true, presence: true
  
  
  #検索
  def self.looks(references, words)
    if references == 'perfect_match'
      @tag = Tag.where('tag_name LIKE ?', "#{words}")
    else
      @tag = Tag.where('tag_name LIKE ?', "%#{words}%")
    end
  end

end
