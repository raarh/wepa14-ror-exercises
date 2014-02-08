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
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end
  def favorite_style
    return nil if ratings.empty?
      beers.group(:style).order("sum_score desc" ).sum(:score).keys[0]
  end
  def favorite_brewery
    return nil if ratings.empty?
    beers.group(:brewery).order("count_brewery_id desc").count("brewery_id").keys[0]
  end
end
