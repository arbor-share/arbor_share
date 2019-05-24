class ProjectsController < ApplicationController

  def index
    @projects = Project.where(active: true).order(:date)
    if params[:sort_by] == 'a-z'
      @projects = Project.where(active: true).order(:title)
    else
    end
  end

  def show

  end


end

