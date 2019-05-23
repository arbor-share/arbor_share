class SessionsController < ApplicationController
  def create
    user = User.find_by(google_id: auth_hash[:uid])
    if user
      session[:user_id] = user.id
      redirect_to '/'
    else
      session[:oauth_details] = session_passthrough
      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def session_passthrough
    {
      google_id: auth_hash[:uid],
      google_token: auth_hash[:credentials][:token],
      full_name: auth_hash[:info][:name],
      avatar_image: auth_hash[:info][:image],
      email: auth_hash[:info][:email],
      full_name: auth_hash[:info][:name],
    }
  end
end
