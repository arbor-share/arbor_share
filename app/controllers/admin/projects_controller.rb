class Admin::ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def create
    project = Project.create(project_params)
    Address.create(location_params.merge(owner: project))
    redirect_to project_path(project)
  end

  private

  def project_params
    params.require(:project).permit(:title, :date, :description, :image, :active).merge({organizer: current_user})
  end

  def location_params
    params.require(:address).permit(:line_1, :line_2, :city, :state, :zip)
  end

end
