class Projects::Carpools::DriversController < ApplicationController

  def destroy
    NotificationMailer.driver_cancelled_carpool(passengers_emails).deliver_now
    #Noah's working on this functionality
    # - Destroy carpool
    # - Warning message
    # - Flash message
    # - Redirect
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
