class ProjectsController < ApplicationController

  def index
    @projects = Project.where(active: true)
  end

  def show
    project = Project.find(params[:id])
    render locals: {
      facade: ProjectFacade.new(project)
    }
  end


end
