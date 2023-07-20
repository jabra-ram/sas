# frozen_string_literal: true

# This is notification model
class Notification < ApplicationRecord
  belongs_to :recipient, class_name: 'Admin'

  scope :unread, -> { where(read_status: false) }
end
