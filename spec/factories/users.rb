FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'ThisIs@Very5Pass' }
    password_confirmation { 'ThisIs@Very5Pass' }
  end
end
