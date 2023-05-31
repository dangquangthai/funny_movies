FactoryBot.define do
  factory :video do
    source { Video::SOURCES.sample }
    source_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    user { build(:user) }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end

  trait :youtube do
    source { 'youtube' }
  end

  trait :vimeo do
    source { 'vimeo' }
  end
end
