# frozen_string_literal: true

# This is create notification migration
class RemoveAgeColumnFromTables < ActiveRecord::Migration[6.1]
  def change
    remove_column :age_criteria, :age, :integer
    remove_column :students, :age, :integer
  end
end
