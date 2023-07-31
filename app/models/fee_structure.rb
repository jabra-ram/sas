# frozen_string_literal: true

# This is fee model
class FeeStructure < ApplicationRecord
  belongs_to :class_category

  validates :admission_fees, presence: { message: "admission fee can't be empty" },
                             numericality: { greater_than_or_equal_to: 0, message: 'must be non-negative' }
  validates :annual_admission_fees, presence: { message: "annual admission fee can't be empty" },
                                    numericality: { greater_than_or_equal_to: 0, message: 'must be non-negative' }
  validates :caution_money, presence: { message: "caution fee can't be empty" },
                            numericality: { greater_than_or_equal_to: 0, message: 'must be non-negative' }
  validates :quarterly_tuition_fees, presence: { message: "quarterly fee can't be empty" },
                                     numericality: { greater_than_or_equal_to: 0, message: 'must be non-negative' }
  validates :id_card_fees, presence: { message: "id card can't be empty" },
                           numericality: { greater_than_or_equal_to: 0, message: 'must be non-negative' }
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
