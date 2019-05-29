class Projects::CarpoolsController < ApplicationController
  def create
    project = Project.find(params[:id])
    if current_user.has_address?
      project.carpools.create(driver: current_user, vehicle: current_user.default_vehicle)
      if project.save
        flash[:success] = "You are now a driver for #{project.title}!"
      else
        flash[:error] = "You were unable to become a driver!"
      end
    else
      flash[:error] = "You were unable to become a driver!"
    end
      redirect_to project_path(project)
  end

  def update
    if current_user.has_address?
      carpool = Carpool.find(params[:carpool_id])
      unless carpool.passengers.include?(current_user) || carpool.driver == current_user
        carpool.passengers << current_user
        if carpool.save
          flash[:success] = "You have joined #{carpool.driver.full_name}'s carpool!"
        end
      else
        flash[:error] = "You were not able to join this carpool"
      end
    else
      flash[:error] = "You were not able to join this carpool"
    end
    redirect_to project_path(params[:id])
  end

  def show
    # passing one obj to view
    @project = Project.find(params[:id])
    @carpool = Carpool.find(params[:carpool_id])
    # require 'pry'; binding.pry
  end

  def destroy
    require 'pry'; binding.pry
  end
end
