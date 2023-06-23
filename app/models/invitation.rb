class Invitation < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :token, presence: true, uniqueness: true
    validates :expires_at, presence: true
end
