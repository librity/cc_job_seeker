# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    job
    job_seeker
    cover_letter { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }

    trait :skip_validate do
      to_create { |instance| instance.save validate: false }
    end
  end
end
