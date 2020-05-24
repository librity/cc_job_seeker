# frozen_string_literal: true

FactoryBot.define do
  factory :head_hunter do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.unique.password min_length: 8 }
    name { Faker::Name.unique.name }
    avatar { FileUploadSupport.png }

    trait :skip_validation do
      to_create { |instance| instance.save validate: false }
    end

    trait :with_social_name do
      social_name { Faker::Name.unique.name }
    end
  end
end
