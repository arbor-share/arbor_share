class Projects::Carpools::DriversController < ApplicationController

  def destroy
    NotificationMailer.driver_cancelled_carpool(passengers_emails).deliver_now
    project = Project.find(params[:id])
    carpool = Carpool.find(params[:carpool_id])
    carpool.carpool_passengers.destroy_all
    carpool.destroy

    flash[:alert] = 'You are no longer a driver.'
    redirect_to project_path(project)
  end

  def passengers_emails(carpool_id)

    # passengers = User.select(:email)
    #                  .joins(carpool_passengers: :carpools)
    #                  .where("carpools.id = ?, #{carpool_id}")

    # SELECT users.email from users
	  #  JOIN carpool_passengers
	  #   ON users.id = carpool_passengers.passenger_id
	  #  JOIN carpools
	  #   ON carpool_passengers.carpool_id = carpools.id;
    #  WHERE carpools.id = 1;

  end

end
