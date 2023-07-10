class InvitationsController < ApplicationController
  before_action :authorize

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(token: SecureRandom.urlsafe_base64, email: params[:invitation][:email], expires_at:24.hours.from_now)
    
    if @invitation.save
      AdminMailer.with(invitation: @invitation).invite_email.deliver_later
      flash[:notice] = "Invitation sent successfully"
      redirect_to admins_path
    else
      flash[:alert] = "Something went wrong!!!"
      render "new"
    end

  end

end
