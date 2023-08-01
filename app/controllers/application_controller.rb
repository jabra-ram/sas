# frozen_string_literal: true

# This is application controller
class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  private

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  helper_method :current_admin

  def authorize
    return unless current_admin.nil?

    redirect_to login_path, alert: 'Not Authorized!!!'
  end

  def search_obj(params, model)
    query = extract_query(params)
    results = perform_search(query, model)
    results = apply_filters(results, params)
    sort_results(results, params[:search_students][:sort_by])
  end

  def extract_query(params)
    params[:search_students].presence && params[:search_students][:query]
  end

  def perform_search(query, model)
    query.present? ? model.search_query(query.strip).records : model.all
  end

  def apply_filters(results, params)
    col = params[:search_students][:filter_column]
    return results.where(col => params[:search_students][:filter_value]) unless col.nil? || col.empty?

    results
  end

  def sort_results(results, sort_by)
    return results.order(sort_by => :asc) unless sort_by.nil? || sort_by.empty?

    results
  end
end
