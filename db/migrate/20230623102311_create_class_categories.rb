# frozen_string_literal: true

# This is create class migration
class CreateClassCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :class_categories do |t|
      t.integer :classname

      t.timestamps
    end
  end
end
