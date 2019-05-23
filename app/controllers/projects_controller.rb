class ProjectsController < ApplicationController

  def index
    @projects = Project.where(active: true)
  end

  def show

  end


end

