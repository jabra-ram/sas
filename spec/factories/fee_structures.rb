FactoryBot.define do
  factory :fee_structure do
    admission_fees {500}
    annual_admission_fees {200}
    caution_money {100}
    quarterly_tuition_fees {150}
    id_card_fees {50}
    total {1000}
    association :class_category
  end
end
