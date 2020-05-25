# frozen_string_literal: true

FactoryBot.define do
  factory :job_application_interview, class: 'Job::Application::Interview' do
    association :application, factory: :job_application
    head_hunter

    date { Faker::Time.forward days: 30 }
    address { Faker::Address.unique.full_address }

    trait :skip_validation do
      to_create { |instance| instance.save validate: false }
    end

    trait :public_feedback do
      public_feedback { true }
    end

    trait :occurred do
      occurred { true }
    end

    trait :not_occurred do
      occurred { false }
    end

    trait :with_feedback do
      feedback { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }
    end
  end
end
