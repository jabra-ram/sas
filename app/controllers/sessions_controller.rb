# frozen_string_literal: true

# This is sessions controller
class SessionsController < ApplicationController
  skip_before_action :authorize, only: %i[new create]
  def new
    redirect_to admins_path, notice: 'You are already logged in!' if current_admin
    @admin = Admin.new
  end

  def create
    @admin = Admin.find_by(email: params[:email])

    if @admin&.authenticate(params[:password])
      session[:admin_id] = @admin.id
      redirect_to admins_path, notice: 'Logged In'
    else
      flash.now[:alert] = 'Incorrect email or password!'
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    flash[:notice] = 'Logged Out!'
    redirect_to login_path
  end
end
