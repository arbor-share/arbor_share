class NotificationMailer < ApplicationMailer

  def driver_cancelled_carpool(passengers_emails, project)
    # @url  = '/'
    @url  = default_url_options[:host]
    #change to direct to project show page
    @project = project
    binding.pry
    mail(to: passengers_emails, subject: 'Your Ride Was Cancelled')
  end

end
