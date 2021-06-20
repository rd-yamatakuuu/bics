class Speciality < ApplicationRecord

  has_many :user_specialities, dependent: :destroy
  
  validates :name, presence: true
  
  
  #検索
  def self.looks(references, words)
    if references == 'perfect_match'
      @speciality = Speciality.where('name LIKE ?', "#{words}")
    else
      @speciality = Speciality.where('name LIKE ?', "%#{words}%")
    end
  end
end
