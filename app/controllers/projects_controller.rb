class ProjectsController < ApplicationController

  def index
    @projects = Project.where(active: true).order(:date)
  end

  def show

  end


end

