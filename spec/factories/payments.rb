# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    student_id { 1 }
    amount { 75_000 }
    association :student
  end
end
