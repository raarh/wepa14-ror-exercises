class Membership < ActiveRecord::Base
  validates :beer_club_id, uniqueness: {scope: :user_id, message: "Double?"}
  belongs_to :user
  belongs_to :beer_club
end
