class AddReferences < ActiveRecord::Migration[6.1]
  def change
    create_join_table :class_categories, :section, table_name: :class_sections
    add_reference :age_criteria, :class_category, foreign_key: true
    add_reference :fee_structures, :class_category, foreign_key: true
    add_reference :students, :class_category, foreign_key: true
    add_reference :students, :section, foreign_key: true
    add_reference :payments, :student, foreign_key: true
  end
end
