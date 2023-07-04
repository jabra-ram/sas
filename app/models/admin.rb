class Admin < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true
    has_many :notifications, foreign_key:'recipient_id'
end
