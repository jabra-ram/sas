# frozen_string_literal: true

# This is invitation model
class Invitation < ApplicationRecord
  validates :email, presence: { message: "email can't be empty" },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'invalid email' }
  validates :token, presence: true, uniqueness: true
  validates :expires_at, presence: true
  validate :admin_exists
  before_create { email.downcase! }
  def admin_exists
    return if Admin.find_by(email:).nil?

    errors.add(:email, 'admin already exists with this email!')
  end
end
