class Projects::Carpools::DriversController < ApplicationController

  def destroy
    project = Project.find(params[:id])
    carpool = Carpool.find(params[:carpool_id])
    passengers_emails = carpool.passengers.pluck(:email)
    NotificationMailer.driver_cancelled_carpool(passengers_emails, project).deliver_now
    carpool.carpool_passengers.destroy_all
    carpool.destroy
    flash[:alert] = 'You are no longer a driver.'
    redirect_to project_path(project)
  end

end
