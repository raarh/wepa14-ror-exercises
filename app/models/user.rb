class User < ActiveRecord::Base
  include RatingAverage
  validates_uniqueness_of :username
  validates_length_of :username, minimum: 3
  validates_length_of :username, maximum: 15
  has_many :ratings
  has_many :beers, through: :ratings

end
