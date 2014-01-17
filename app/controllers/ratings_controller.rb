class RatingsController < ApplicationController
  before_action :set_ratings, only: [:show, :edit, :update, :destroy]
  def index
    @ratings = Rating.all
  end
  def show
  end
  def new
    @ratings = Rating.new
  end
  def edit
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ratings
    @ratings = Rating.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def brewery_params
    params.require(:brewery).permit(:name, :year)
  end

end
