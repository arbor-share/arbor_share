class CarpoolsController < ApplicationController
  before_action :present_for_carpool?
  def show
    carpool = Carpool.find(params[:id])
    render locals: {
      facade: CarpoolFacade.new(carpool)
    }
  end

  private

  def present_for_carpool?
    if current_user
      user = User.find(current_user.id)
      carpool = Carpool.find(params[:id])
      render file: '/public/404' unless user.in_carpool?(carpool)
    else
      render file: '/public/404'
    end
  end
end
