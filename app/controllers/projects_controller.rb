class ProjectsController < ApplicationController

  def index
    if params[:sort_by] == 'a-z'
      @projects = Project.sorted(params[:sort_by])
    elsif params[:sort_by] == 'needs_driver'
      @projects = Project.sorted(params[:sort_by])
    else
      @projects = Project.sorted
    end
  end

  def show

  end


end

