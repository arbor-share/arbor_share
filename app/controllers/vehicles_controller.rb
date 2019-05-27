class VehiclesController < ApplicationController
  def update
    make_default(params[:id]) if params[:_method] == 'patch'
  end

  private

  def make_default(id)
    Vehicle.make_default(id, owner)
    if params[:user_id]
      redirect_to profile_path
    end
  end

  def owner
    if params[:user_id]
      User.find(params[:user_id])
    end
  end
end
