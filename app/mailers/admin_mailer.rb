class AdminMailer < ApplicationMailer 
  default from: 'jrchoudhary2410@gmail.com'

  def invite_email
    @invitation = params[:invitation]
    mail(to: @invitation.email, subject: 'Invitation to Admin App')
  end

  def confirmation_email
    @admin = params[:admin]
    mail(to: @admin.email, subject: 'Admin Account Confirmation')
  end
end
