FactoryBot.define do
  factory :payment do
    student_id {1}
    amount {75000}
    association :student
  end
end
