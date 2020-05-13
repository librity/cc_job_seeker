FactoryBot.define do
  factory :head_hunter do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
  end
end
