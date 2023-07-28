# frozen_string_literal: true

# This is sections controller
class SectionsController < ApplicationController
  before_action :authorize

  def index
    @sections = Section.all.order(section: :asc)
  end

  def new
    @section = Section.new
  end

  def dropdown_sections
    @class_category = ClassCategory.find(params[:id])
    render json: @class_category.sections
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to sections_path, notice: 'Section created successfully!'
    else
      render :new, alert: 'Enter correct details please!'
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update(section_params)
      redirect_to sections_path, notice: 'Section edited successfully!'
    else
      render :new, alert: 'Enter correct details please!'
    end
  end

  def destroy
    @section = Section.find(params[:id])
    if @section.class_categories.nil? || @section.class_categories.empty?
      @section.destroy
      return redirect_to sections_path, notice: 'Section deleted successfully!'
    end
    redirect_to sections_path, alert: "There are classes having this section, you can't delete it!"
  end

  private

  def section_params
    params.require(:section).permit(:section)
  end
end
