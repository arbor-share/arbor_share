class NotificationMailer < ApplicationMailer

  def driver_cancelled_carpool(passengers_emails, project)
    @url  = default_url_options[:host]
    @project = project
    mail(to: passengers_emails, subject: 'Your Ride Was Cancelled')
  end

end
