class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_specialities, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ideas, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :followed_user, through: :followed, source: :follower

  attachment :profile_image



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

end
