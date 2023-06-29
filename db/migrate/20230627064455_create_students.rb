class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.date :date_of_birth
      t.integer :age
      t.integer :academic_year
      t.string :father_name
      t.string :mother_name
      t.text :address
      t.bigint :contact_number

      t.timestamps
    end
  end
end
