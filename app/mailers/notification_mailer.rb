class NotificationMailer < ApplicationMailer

  def driver_cancelled_carpool(passengers_emails)
    # @url  = 'http://arbor-share.herokuapp.com/'
    #change to direct to project show page
    @url  = 'localhost:3000'
    # @project = params[:project] #???
    mail(to: passengers_emails, subject: 'Your Ride Was Cancelled')
  end

end
