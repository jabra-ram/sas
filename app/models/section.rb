# frozen_string_literal: true

# This is section model
class Section < ApplicationRecord
  has_and_belongs_to_many :class_categories, join_table: 'class_sections'
  has_many :students
  before_save { section.upcase! }

  validates :section, presence: { message: "section can't be empty" },
                      uniqueness: { message: 'section already exists', case_sensitive: false },
                      format: { with: /[A-Z]/i, message: 'Enter (A-Z) only' },
                      length: { minimum: 1, maximum: 1, message: 'Must be 1 character(A-Z)' }
end
