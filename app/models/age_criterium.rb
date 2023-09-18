# frozen_string_literal: true

# This is age criteria model
class AgeCriterium < ApplicationRecord
  belongs_to :class_category

  validates :date_of_birth_after, presence: { message: 'Enter a valid date' }
  validates :date_of_birth_before, presence: { message: 'Enter a valid date' }
  validates :date_as_on, presence: { message: 'Enter a valid date' }
  validates :age, presence: true, numericality: { greater_than: 0, message: 'Not a valid age' }
  before_save :date_range_validation
  scope :exist_for_class_category, ->(class_category_id) { where(class_category_id:) }
  def date_range_validation
    return unless date_of_birth_before <= date_of_birth_after

    errors.add(:date_of_birth_before, 'must be greater than date_of_birth_after')
    throw(:abort)
  end
end
