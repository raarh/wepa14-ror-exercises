class Style < ActiveRecord::Base
  has_many :beers
  validates :style, uniqueness: {scope: :style, message: "Double?"}


  def to_s
    self.style
  end
end
