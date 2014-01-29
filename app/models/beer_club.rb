class BeerClub < ActiveRecord::Base
  has_many :memberships, :foreign_key => "beer_club_id"
  has_many :users, through: :memberships
  validates :name, :presence => true
  validates :city, :presence => true
  validates :founded, :presence => true
  validates :founded, numericality: {greater_than_or_equal_to: 1020,
                                       only_integer: true}
  validates :name, length: { minimum: 3, maximum:15}
  def to_s
    self.name
  end
end
