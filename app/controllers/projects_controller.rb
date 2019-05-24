class ProjectsController < ApplicationController

  def index
    @projects = Project.where(active: true).order(:date)
    if params[:sort_by] == 'a-z'
      @projects = Project.where(active: true).order(:title)
    elsif params[:sort_by] == 'needs_driver'
      needs_driver = @projects.find_all do |project|
        project.carpools.empty?
      end
      @projects = needs_driver 
    else
    end
  end

  def show

  end


end

