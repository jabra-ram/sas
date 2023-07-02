class Payment < ApplicationRecord
    belongs_to:student
    enum status: [:Pending, :Processed, :Approved, :Rejected]
    enum mode_of_payment: ['Cash/Check/Draft', 'Credit/Debit Card', 'Net banking']
end
