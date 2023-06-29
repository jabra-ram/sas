class ClassCategoriesController < ApplicationController
  before_action :authorize
  
  def index
    @classes = ClassCategory.all.order_by_name
  end
  def new
    @class_category = ClassCategory.new
  end
  def create 
    @class_category = ClassCategory.new(class_category_params)
    c = ClassCategory.find_by(classname: params[:class_category][:classname])
    @section = Section.find(params[:class_category][:section_id])
    if c
      if c.sections.where(id: @section.id).empty? == false
        redirect_to class_categories_path, notice:"Section already exist in class!"
      else
        c.sections << @section
        redirect_to class_categories_path, notice:"Section added to class!"
      end
    elsif @class_category.save
      @class_category.sections << @section
      redirect_to class_categories_path, notice:"Class created successfully!"
    else
      render "new", alert:"Enter correct details!!!"
    end
  end
  def destroy 
    @class_category = ClassCategory.find(params[:id])
    if @class_category.destroy
      redirect_to class_categories_path, notice:"Record deleted successfully!"
    else
      render "new", alert:"Something went wrong!!!"
    end
  end
  private
    def class_category_params
      params.require(:class_category).permit(:classname)
    end
end
