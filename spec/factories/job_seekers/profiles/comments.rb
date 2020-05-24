# frozen_string_literal: true

FactoryBot.define do
  factory :job_seeker_profile_comment, class: 'JobSeeker::Profile::Comment' do
    profile { create :job_seeker_profile }
    head_hunter
    content { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }

    trait :skip_validation do
      to_create { |instance| instance.save validate: false }
    end
  end
end
