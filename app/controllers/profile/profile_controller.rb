class Profile::ProfileController < Profile::BaseController
  def show
    render locals: {
      user: current_user
    }
  end
end
