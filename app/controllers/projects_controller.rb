class ProjectsController < ApplicationController

  def index
    @projects = Project.where(active: true)
    require 'pry'; binding.pry
  end


end