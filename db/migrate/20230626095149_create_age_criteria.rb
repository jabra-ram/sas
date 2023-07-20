# frozen_string_literal: true

# This is create age criteria migration
class CreateAgeCriteria < ActiveRecord::Migration[6.1]
  def change
    create_table :age_criteria do |t|
      t.date :date_of_birth_after
      t.date :date_of_birth_before
      t.integer :age
      t.date :date_as_on

      t.timestamps
    end
  end
end
