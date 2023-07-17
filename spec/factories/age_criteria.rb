FactoryBot.define do
  factory :age_criterium do
    date_of_birth_after {'31-03-2016'}
    date_of_birth_before {'01-04-2017'}
    age {'6'}
    date_as_on {'01-04-2023'}
    association :class_category
  end
end
