# frozen_string_literal: true

# This is create section migration
class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.string :section

      t.timestamps
    end
  end
end
