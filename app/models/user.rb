class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :requested_friends, -> { where status: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :requested_friends, source: :user

  def confirm_friend(user)
    friend = Friendship.find_by(user_id: user.id, friend_id: id)
    friend.status = true
    friend.save
    Friendship.create!(user_id: id, friend_id: user.id, status: true)
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def user_friend
    friend_ids = friends.map(&:id)
    friend_ids << id
    Post.all.where(user_id: friend_ids)
  end
end
