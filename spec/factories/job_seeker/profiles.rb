# frozen_string_literal: true

FactoryBot.define do
  factory :job_seeker_profile, class: 'JobSeeker::Profile' do
    job_seeker
    date_of_birth { Faker::Date.birthday min_age: 16, max_age: 80 }
    high_school { Faker::Educator.secondary_school }
    college { Faker::Educator.university }
    degrees { (1..3).map { |_n| Faker::Educator.degree }.join ', ' }
    courses { (1..3).map { |_n| Faker::Educator.course_name }.join ', ' }
    interests { (1..3).map { |_n| Faker::IndustrySegments.sub_sector }.join ', ' }
    bio { Faker::Lorem.paragraph_by_chars number: 256, supplemental: false }
    work_experience { (1..3).map { |_n| "#{Faker::Job.title} at #{Faker::Company.name}" }.join ', ' }
    avatar { FileUploadSupport.png }

    trait :skip_validate do
      to_create { |instance| instance.save validate: false }
    end
  end
end
