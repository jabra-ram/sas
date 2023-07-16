class Invitation < ApplicationRecord
	validates :email ,presence: { message: "email can't be empty" }, 
									  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'invalid email' },
	                  uniqueness: { message: 'admin already exist', case_sensitive: false }
	validates :token, presence: true, uniqueness: true
	validates :expires_at, presence: true
	before_save { email.downcase! }
end
