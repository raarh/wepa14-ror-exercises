class User < ActiveRecord::Base
  include RatingAverage
  validates_uniqueness_of :username
  validates_length_of :username, minimum: 3
  validates_length_of :username, maximum: 15
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_secure_password

end
