class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by username: params[:username]
    #Tallennetaan sessioon kirjautuneen käyttäjän id
    session[:user_id] = user.id if not user.nil?
    redirect_to user_path(user)
  end

  def destroy
    #Nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end

end