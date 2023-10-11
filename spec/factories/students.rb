# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    association :class_category, factory: :class_category
    association :section, factory: :section
    name { 'mohit verma' }
    email { 'mohit@gmail.com' }
    date_of_birth { '02-03-2016' }
    academic_year { '2023' }
    father_name { 'rajesh verma' }
    mother_name { 'menka verma' }
    address { 'kolkata' }
    contact_number { 123_456_789 }
    after(:build) do |student|
      student.photo.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images', 'profile.webp')),
        filename: 'profile.webp',
        content_type: 'image/webp'
      )
    end
  end
end
