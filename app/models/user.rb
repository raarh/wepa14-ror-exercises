class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true
  validates :username, length: { minimum: 3, maximum:15}
  validates :password, length: { minimum: 4 }
  validates :password, format: {with: /\d/, message: "At least one number"}
  validates :password, format: {with: /[A-Z]/, message: "At least one upper-case letter"}
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_secure_password

  def favorite_beer

  end
end
