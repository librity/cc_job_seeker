# frozen_string_literal: true

FactoryBot.define do
  factory :job_application, class: 'Job::Application' do
    job
    job_seeker
    cover_letter { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }

    trait :skip_validate do
      to_create { |instance| instance.save validate: false }
    end

    trait :rejected do
      rejection_feedback { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }
    end
  end
end
