class PlacesController < ApplicationController

  def index

  end

  def show
    @place = BeermappingApi.get_place_info(params[:id])

    if @place.empty?
      redirect_to places_path, notice: "Wrong location id in  #{params[:id]}"
    end


  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end