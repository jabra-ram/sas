# frozen_string_literal: true

# This is helper Class Categories
module ClassCategoriesHelper
  def check_and_save(cls)
    if cls&.sections&.exists?(id: @section.id)
      return redirect_to(class_categories_path,
                         alert: 'Section already exists in class!')
    end

    if @class_category.save
      @class_category.sections << @section
      return redirect_to(class_categories_path, notice: 'Class created successfully!')
    end

    return redirect_to(class_categories_path, notice: 'Section added to class!') if cls && cls.sections << @section

    render :new
  end
end
