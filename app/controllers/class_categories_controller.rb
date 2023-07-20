# frozen_string_literal: true

# This is class categories controller
class ClassCategoriesController < ApplicationController
  before_action :authorize
  include ClassCategoriesHelper
  def index
    @classes = ClassCategory.all.order_by_name
  end

  def new
    @class_category = ClassCategory.new
  end

  def create
    @class_category = ClassCategory.new(class_category_params)
    cls = ClassCategory.find_by(classname: params[:class_category][:classname])
    @section = Section.find(params[:class_category][:section_id])
    check_and_save(cls)
  end

  def destroy
    @class_category = ClassCategory.find(params[:id])
    if @class_category.destroy
      redirect_to class_categories_path, notice: 'Record deleted successfully!'
    else
      render :new, alert: 'Something went wrong!!!'
    end
  end

  private

  def class_category_params
    params.require(:class_category).permit(:classname)
  end
end
