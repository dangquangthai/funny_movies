FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'ThisIs@Very5Pass' }
    password_confirmation { 'ThisIs@Very5Pass' }
  end
end
