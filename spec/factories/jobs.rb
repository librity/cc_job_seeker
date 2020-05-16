# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }
    skills { Faker::Lorem.words }
    salary_floor { Faker::Number.within range: 1500..10_000 }
    salary_roof { salary_floor + Faker::Number.within(range: 200..800) }
    position { Faker::Lorem.word }
    location { Faker::Lorem.sentence }
    expires_on { Faker::Date.forward days: 30 }
    head_hunter

    trait :expired do
      expires_on { Faker::Date.backward days: 30 }
    end
  end
end
