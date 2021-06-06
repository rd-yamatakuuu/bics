class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :user_specialities, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :ideas, dependent: :destroy
  
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy #自分がフォローされる側の関係性
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy　#自分がフォローする側の関係性
  has_many :followers, through: reverse_of_relationships, source: :follower　#フォロワーの一覧を取得
  has_many :followings, through: relationships, source: :followed　#フォローしている人の一覧を取得
  
  attachment :profile_image
  
end
