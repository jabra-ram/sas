# frozen_string_literal: true

# This is application model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :where_non_empty, ->(col, value) { where(col => value) }
end
