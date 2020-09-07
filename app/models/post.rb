class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: 'maximum 1000 characters allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
