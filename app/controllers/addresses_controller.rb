class AddressesController < ApplicationController
  def create
    current_user.add_address(address_params)
    redirect_to profile_path
  end

  def update
    make_default(params[:id]) if params[:_method] == 'patch'
  end

  private

  def make_default(id)
    Address.make_default(id, owner)
    if params[:user_id]
      redirect_to profile_path
    end
  end

  def owner
    if params[:user_id]
      User.find(params[:user_id])
    end
  end

  def address_params
    params.require(:address).permit([:line_1, :line_2, :city, :state, :zip])
  end
end
