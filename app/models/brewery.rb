class Brewery < ActiveRecord::Base
  include RatingAverage


  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers
  validates :name, :presence => true
  validates :year, numericality: { only_integer: true }
  validates_with YearValidator

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  def to_s
    self.name
  end
end
