# frozen_string_literal: true

# This is admin mailer
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

  def status_email
    @student = params[:student]
    @message = params[:message]
    mail(to: @student.email, subject: 'Payment status')
  end
end
