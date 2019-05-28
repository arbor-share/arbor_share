class NotificationMailer < ApplicationMailer

  def driver_cancelled_carpool
    @user = params[:user]
    # @url  = 'http://arbor-share.herokuapp.com/'
    @url  = 'localhost:3000'
    # @project = params[:project] #???
    mail(to: @user.email, subject: 'Your Ride Was Cancelled')
  end

end
