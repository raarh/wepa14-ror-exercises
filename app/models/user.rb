class User < ActiveRecord::Base
  include RatingAverage
  validates_uniqueness_of :username
  validates_length_of :username, minimum: 3
  validates_length_of :password, minimum: 3
  validates_length_of :username, maximum: 15
  validates :password, format: {with: /\d/, message: "At least one number"}
  validates :password, format: {with: /[A-Z]/, message: "At least one upper-case letter"}
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_secure_password

end
