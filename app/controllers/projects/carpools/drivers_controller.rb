class Projects::Carpools::DriversController < ApplicationController
  
  def destroy
    project = Project.find(params[:id])
    carpool = Carpool.find(params[:carpool_id])
    carpool.carpool_passengers.destroy_all
    carpool.destroy

    flash[:alert] = 'You are no longer a driver.'
    redirect_to project_path(project)
  end
end
