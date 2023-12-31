# frozen_string_literal: true

# This is create payment migration
class CreatePayments < ActiveRecord::Migration[6.1]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :payments do |t|
      t.string :student_name
      t.string :email
      t.integer :classname
      t.integer :academic_year
      t.text :address
      t.integer :contact_number
      t.integer :mode_of_payment
      t.integer :amount
      t.integer :status
      t.text :notes

      t.timestamps
    end
  end
end
# rubocop:enable Metrics/MethodLength
