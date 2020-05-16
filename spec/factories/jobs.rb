# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }
    skills { Faker::Lorem.words }
    salary_floor { Faker::Number.number digits: 4 }
    salary_roof { salary_floor + Faker::Number.number(digits: 3) }
    position { Faker::Lorem.word }
    location { Faker::Lorem.sentence }
    retired { false }
    expires_on { Faker::Date.forward days: 30 }

    trait :expired do
      expires_on { Faker::Date.backward days: 30 }
    end

    trait :retired do
      retired { true }
    end
  end
end
