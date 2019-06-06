class VehiclesController < ApplicationController
  def create
    current_user.add_vehicle(vehicle_params)
    redirect_to profile_path
  end

  def update
    make_default(params[:id]) if params[:_method] == 'patch'
  end

  def put
    vehicle = Vehicle.find(params[:vehicle_id])
    vehicle.update(vehicle_params)
    redirect_to profile_path
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

  def vehicle_params
    params.require(:vehicle).permit([:make, :model, :year, :color,
                                     :passenger_limit, :fuel_type,
                                     :fuel_efficiency, :fuel_efficiency_unit])
  end
end
