class ProjectsController < ApplicationController

  def index
    @projects = Project.where(active: true)
  end


end