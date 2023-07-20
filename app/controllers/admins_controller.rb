# frozen_string_literal: true

# This is Admins Controller
class AdminsController < ApplicationController
  include AdminsHelper
  before_action :authorize, only: [:index]
  skip_before_action :verify_authenticity_token, only: :mark_read

  def invite
    @invitation = Invitation.find_by(token: params[:token])
    if @invitation.nil?
      redirect_to login_path, alert: 'Invalid invitation link!!!'
    elsif @invitation.expires_at < Time.now
      redirect_to login_path, alert: 'Invitation link expired!!!'
    end
    @admin = Admin.new
  end

  def process_invite
    @invitation = Invitation.find_by(token: params[:token])
    @admin = Admin.new(email: @invitation.email, password: params[:admin][:password],
                       password_confirmation: params[:admin][:password_confirmation])
    if @admin.save
      save_admin
      redirect_to login_path, notice: 'Thank you for signing up! You can login now.'
    else
      render :invite
    end
  end

  def mark_read
    current_admin.notifications.unread.update(read_status: true)
    render json: { message: 'All notifications marked as read' }
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
