# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    email { 'abcdef@gmail.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
