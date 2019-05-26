class AddressesController < ApplicationController
  def update
    make_default(params[:id]) if params[:_method] == 'patch'
  end

  private

  def make_default(id)
    Address.make_default(id)
    if params[:user_id]
      redirect_to profile_path
    end
  end
end
