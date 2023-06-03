FactoryBot.define do
  factory :video do
    source { 'youtube' }
    source_url { "https://youtube.com/watch?v=#{Faker::Alphanumeric.alphanumeric(number: 10)}" }
    user { build(:user) }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end

  trait :vimeo do
    source { 'vimeo' }
    source_url { "https://vimeo.com/#{Faker::Number.number(digits: 9)}" }
  end
end
