class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_specialities, dependent: :destroy
  has_many :specialities, through: :user_specialities
  has_many :chats
  has_many :chat_rooms
  has_many :rooms, through: :chat_rooms
  has_many :comments, dependent: :destroy
  has_many :ideas, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :followed_user, through: :followed, source: :follower
  
  validates :name, presence: true
  validates :kana_name, presence: true
  validates :introduction, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  attachment :profile_image
  
  def speciality_check(user, speciality_id)
    user.specialities.include?(speciality_id)
  end


  def speciality_check(user_specialities)
    current_specialities = self.specialities.pluck(:name) unless self.specialities.nil?
    old_specialities = current_specialities - user_specialities
    new_specialities = user_specialities - current_specialities

    old_specialities.each do |old_speciality|
      self.specialities.delete Speciality.find_by(name: old_specialities)
    end

    new_specialities.each do |new_speciality|
      speciality = Speciality.find_or_create_by(name: new_speciality)
      self.specialities << speciality
    end
  end


  #follow関係
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end
  
  #退会した場合のログイン制御
  def active_for_authentication?
    super && (self.status == false)
  end
  
  #検索
  def self.looks(references, words)
    if references == 'perfect_match'
      @user = User.where('name LIKE ?', "#{words}")
    else
      @user = User.where('name LIKE ?', "%#{words}%")
    end
  end

end
