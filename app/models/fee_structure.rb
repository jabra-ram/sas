class FeeStructure < ApplicationRecord
    belongs_to :class_category
    validates :admission_fees, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :annual_admission_fees, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :caution_money, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :quarterly_tuition_fees, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :id_card_fees, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :total, presence: true, numericality: {greater_than_or_equal_to: 0}
end
