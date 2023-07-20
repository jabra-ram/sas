# frozen_string_literal: true

# This is remove column from payment migration
class RemoveColumnsFromPayment < ActiveRecord::Migration[6.1]
  def change
    remove_column :payments, :student_name, :string
    remove_column :payments, :email, :string
    remove_column :payments, :classname, :integer
    remove_column :payments, :academic_year, :integer
    remove_column :payments, :address, :text
    remove_column :payments, :contact_number, :integer
  end
end
