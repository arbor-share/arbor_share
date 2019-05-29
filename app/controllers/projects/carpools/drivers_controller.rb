class Projects::Carpools::DriversController < ApplicationController
  
  def destroy
    require 'pry'; binding.pry
    @project = Project.find(params[:id])
    # @carpool = Carpool.find(params[:carpool_id])
    
  end
end
