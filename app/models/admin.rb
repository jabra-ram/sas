# frozen_string_literal: true

# This is admin model
class Admin < ApplicationRecord
  has_secure_password
  validates :email, presence: { message: "email can't be empty" },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'invalid email' },
                    uniqueness: { message: 'user already exist', case_sensitive: false }
  validates :password, presence: true,
                       length: { minimum: 6, maximum: 16, message: 'password must be 6 to 16 characters' }
  validates :password_confirmation, presence: true,
                                    length: { minimum: 6, maximum: 16, message: 'password must be 6 to 16 characters' }
  has_many :notifications, foreign_key: 'recipient_id'
  before_save { email.downcase! }
end
