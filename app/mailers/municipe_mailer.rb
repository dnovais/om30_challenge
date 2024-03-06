class MunicipeMailer < ApplicationMailer
  def registration_confirmation(municipe)
    @municipe = municipe
    mail(to: @municipe.email, subject: 'Registration Confirmation')
  end

  def status_change_notification(municipe)
    @municipe = municipe
    mail(to: @municipe.email, subject: 'Status Change Notification')
  end
end
