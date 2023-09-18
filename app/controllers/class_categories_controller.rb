# frozen_string_literal: true

# This is class categories controller
class ClassCategoriesController < ApplicationController
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
    return redirect_to class_categories_path, alert: 'Class already exist! You can edit the class.' unless cls.nil?

    save(params[:class_category][:sections])
  end

  def edit
    @class_category = ClassCategory.find(params[:id])
  end

  def update
    @class_category = ClassCategory.find(params[:id])
    sections = params[:class_category][:sections]
    return redirect_to edit_class_category_path, alert: 'Choose atleast 1 section.' if sections.length <= 1

    @class_category.sections.destroy_all
    update_and_save(sections, class_category_params)
  end

  def destroy
    @class_category = ClassCategory.find(params[:id])
    if @class_category.destroy
      redirect_to class_categories_path, notice: 'Record deleted successfully!'
    else
      redirect_to class_categories_path, alert: 'Something Went Wrong!!!'
    end
  end

  private

  def class_category_params
    params.require(:class_category).permit(:classname, :sections)
  end
end
