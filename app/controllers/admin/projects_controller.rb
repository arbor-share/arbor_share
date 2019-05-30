class Admin::ProjectsController < Admin::BaseController

  def new
    project = Project.new
    project.location = Address.new
    render locals: {
      project: project
    }
  end

  def create
    project = Project.new(project_params)
    if project.save
      Address.create(location_params.merge(owner: project))
      flash[:success] = "Your project was successfully created!"
      redirect_to admin_project_path(project)
    else
      flash.now[:error] = project.errors.full_messages
      render action: :new, locals: {
        project: project
      }
      # redirect_to new_admin_project_path
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def index
    @projects = Project.all
  end

  def edit
    render locals: {
      project: Project.find(params[:id])
    }
  end

  def update
    project = Project.find(params[:id])
    if project.update(project_params)
      flash[:success] = "Your project was updated successfully!!"
      redirect_to admin_dashboard_path
    else
      flash.now[:error] = project.errors.full_messages
      render action: :edit, locals: {
        project: project
      }
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.location.destroy
    project.destroy
    flash[:success] = "Project successfully deleted!"
    redirect_to admin_dashboard_path
  end

  private

  def project_params
    params.require(:project).permit(
          :title, :date, :description, :image, :active,
          location_attributes: [
            :line_1, :line_2, :city, :state, :zip, :longitude, :latitude
          ]
        ).merge({organizer: current_user})
  end
end
