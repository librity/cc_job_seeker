# frozen_string_literal: true

FactoryBot.define do
  factory :job_seeker do
    email { Faker::Internet.email }
    password { Faker::Internet.password min_length: 8 }
  end
end