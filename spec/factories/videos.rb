FactoryBot.define do
  factory :video do
    source { 'youtube' }
    source_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    source_url { "https://youtube.com/watch?v=#{source_id}" }
    user { build(:user) }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end

  trait :vimeo do
    source { 'vimeo' }
    source_url { "https://vimeo.com/#{Faker::Number.number(digits: 9)}" }
  end
end
