# frozen_string_literal: true

# This is payment model
class Payment < ApplicationRecord
  belongs_to :student

  enum status: %i[Pending Processed Approved Rejected]
  enum mode_of_payment: ['Cash/Check/Draft', 'Credit/Debit Card', 'Net banking']

  validates :student_id, presence: { message: 'enter id' },
                         numericality: { greater_than: 0, message: 'enter valid student id' }
  validates :mode_of_payment, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0, message: 'enter valid amount' }
end
