# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    position { Faker::Job.unique.position }
    title { Faker::Job.unique.title }
    description { Faker::Lorem.unique.paragraph_by_chars number: 256, supplemental: false }
    skills { (1..3).map { |_n| Faker::Job.key_skill }.join ', ' }
    salary_floor { Faker::Number.unique.within range: 1500..10_000 }
    salary_roof { salary_floor + Faker::Number.unique.within(range: 200..800) }
    location { Faker::Address.unique.full_address }
    expires_on { Faker::Date.unique.forward days: 60 }
    head_hunter

    trait :skip_validate do
      to_create { |instance| instance.save validate: false }
    end

    trait :expired do
      expires_on { Faker::Date.unique.backward days: 30 }
    end
  end
end
