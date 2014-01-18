module RatingAverage
  def rating_average
    ratings.average 'score'
  end
end