class UsersController < ApplicationController
  def new
   render locals: {
     new_user: User.new(session[:oauth_details])
   }
  end

  private

  def user_params
    session[:oauth_details].merge(
      params.require(:user)
            .permit([:full_name, :avatar_image, :email, :about])
    )
  end
end
