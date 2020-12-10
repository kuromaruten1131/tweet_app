class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  validates :content, length: {in: 1..140}

  def user
    return User.find_by(id: self.user_id)
  end
end
