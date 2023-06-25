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
    if @class_category.save 
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
      params.require(:class_category).permit(:classname,:section_id)
    end
end
