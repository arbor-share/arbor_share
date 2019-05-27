class Admin::ProjectsController < Admin::BaseController

  def new
    @project = Project.new
  end

  def create
    project = Project.create(project_params)
    Address.create(location_params.merge(owner: project))
    flash[:success] = "Your project was successfully created!"
    redirect_to admin_project_path(project.id)
  end

  def show
    @project = Project.find(params[:id])
  end

  def index
    @projects = Project.all
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])
    if project.update(project_params)
      if Address.update(location_params.merge(owner: project))
        flash[:success] = "Your project was updated successfully!!"
        redirect_to admin_dashboard_path
      else
        flash[:alert] = "Invalid entry. Please try again."
        redirect_to edit_admin_project_path(project)
      end
    else
      flash[:alert] = "Invalid entry. Please try again."
      redirect_to edit_admin_project_path(project)
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :date, :description, :image, :active).merge({organizer: current_user})
  end

  def location_params
    params.require(:address).permit(:line_1, :line_2, :city, :state, :zip)
  end

end
