class InvitationsController < ApplicationController
  before_action :authorize

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(token: SecureRandom.urlsafe_base64, email: params[:invitation][:email], expires_at:24.hours.from_now)
    
    if @invitation.save
      AdminMailer.with(invitation: @invitation).invite_email.deliver_now
      redirect_to admins_path, notice:'Invitation sent successfully'
    else
      render :new, alert:'Something went wrong!!!' 
    end

  end

end
