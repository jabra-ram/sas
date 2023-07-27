# frozen_string_literal: true

# This is helper Class Categories
module ClassCategoriesHelper
  def check_and_save(sections)
    sections.each do |id|
      unless id.empty?
        section = Section.find(id)
        @class_category.sections << section unless section.nil?
      end
    end
  end
end
