# frozen_string_literal: true

FactoryBot.define do
  factory :job_application_offer, class: 'Job::Application::Offer' do
    association :application, factory: :job_application
    head_hunter

    start_date { Faker::Date.forward days: 90 }
    salary { Faker::Number.unique.within range: 1039..10_000 }
    responsabilities { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }
    benefits { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }

    expectations { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }
    bonus { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }

    trait :skip_validation do
      to_create { |instance| instance.save validate: false }
    end

    trait :accepted do
      status { 1 }
    end

    trait :rejected do
      status { 2 }
    end

    trait :with_feedback do
      feedback { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }
    end

    trait :without_expectations do
      expectations { nil }
    end

    trait :without_bonus do
      bonus { nil }
    end

    trait :old do
      start_date { Faker::Date.backward days: 30 }
    end
  end
end
