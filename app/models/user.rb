class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  validates :nickname, length: {in: 1..20}
  validates :email, length: {in: 1..100}
  validates :desc, length: {maximum: 300}


  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end
end
