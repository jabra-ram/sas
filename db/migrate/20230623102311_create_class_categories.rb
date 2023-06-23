class CreateClassCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :class_categories do |t|
      t.integer :classname
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
