# frozen_string_literal: true

# This is helper Class Categories
module ClassCategoriesHelper
  def save(sections)
    if @class_category.save
      add_sections(sections)
      redirect_to class_categories_path, notice: 'class added successfully!'
    else
      render :new
    end
  end

  def update_and_save(sections, params)
    if @class_category.update(params)
      add_sections(sections)
      redirect_to class_categories_path, notice: 'class Updated successfully!'
    else
      render :edit
    end
  end

  def add_sections(sections)
    sections.each do |id|
      unless id.empty?
        section = Section.find(id)
        @class_category.sections << section unless section.nil?
      end
    end
  end
end
