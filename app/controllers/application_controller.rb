# frozen_string_literal: true

# This is application controller
class ApplicationController < ActionController::Base
  private

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  helper_method :current_admin

  def authorize
    return unless current_admin.nil?

    redirect_to login_path, alert: 'Not Authorized!!!'
  end
end
