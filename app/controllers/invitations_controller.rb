# frozen_string_literal: true

# This is invitation controller
class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(token: SecureRandom.urlsafe_base64, email: params[:invitation][:email],
                                 expires_at: 24.hours.from_now)
    if @invitation.save
      AdminMailer.with(invitation: @invitation).invite_email.deliver_now
      redirect_to admins_path, notice: 'Invitation sent successfully'
    else
      render :new
    end
  end
end
