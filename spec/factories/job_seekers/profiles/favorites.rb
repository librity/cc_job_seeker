# frozen_string_literal: true

FactoryBot.define do
  factory :job_seeker_profile_favorite, class: 'JobSeeker::Profile::Favorite' do
    profile { create :job_seeker_profile }
    head_hunter

    trait :skip_validation do
      to_create { |instance| instance.save validate: false }
    end
  end
end
