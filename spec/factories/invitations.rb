# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    email { 'testing@gmail.com' }
    token { SecureRandom.urlsafe_base64 }
    expires_at { 24.hours.from_now }
  end
end
