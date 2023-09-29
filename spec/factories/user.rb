FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name[0..19] }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end
end
