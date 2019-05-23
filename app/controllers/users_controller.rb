class UsersController < ApplicationController
  def new
   render locals: {
     new_user: User.new(session[:oauth_details])
   }
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      session[:oauth_details] = nil
    else
      # WE HAVE PORBLEM
      binding.pry
    end
    redirect_to '/'
  end

  private

  def user_params
    session[:oauth_details].merge(
      params.require(:user)
            .permit([:full_name, :avatar_image, :email, :about])
    )
  end
end
