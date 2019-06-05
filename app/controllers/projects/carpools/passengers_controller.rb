class Projects::Carpools::PassengersController < ApplicationController

  def patch
    project = Project.find(params[:id])
    carpool = Carpool.find(params[:carpool_id])
    carpool.carpool_passengers.find_by(passenger_id: current_user.id).destroy
    flash[:alert] = 'You are no longer a passenger.'
    redirect_to project_path(project)
  end

end
