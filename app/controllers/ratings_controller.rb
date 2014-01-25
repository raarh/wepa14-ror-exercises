class RatingsController < ApplicationController
  #before_action :set_ratings, only: [:show, :edit, :update, :destroy]
  def index
    @ratings = Rating.all
  end
  def show
  end
  def new
    @rating = Rating.new
    @beers = Beer.all
  end
  def edit
  end
  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path(current_user)
    else
      @beers = Beer.all
      render :new
    end

  end
  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to :back
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ratings
    @ratings = Rating.find(params[:id])
  end

end
