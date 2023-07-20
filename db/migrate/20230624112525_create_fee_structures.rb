# frozen_string_literal: true

# This is create fee structure migration
class CreateFeeStructures < ActiveRecord::Migration[6.1]
  def change
    create_table :fee_structures do |t|
      t.integer :admission_fees
      t.integer :annual_admission_fees
      t.integer :caution_money
      t.integer :quarterly_tuition_fees
      t.integer :id_card_fees
      t.integer :total

      t.timestamps
    end
  end
end
