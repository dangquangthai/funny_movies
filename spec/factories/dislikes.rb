FactoryBot.define do
  factory :dislike do
    user { build(:user) }
    dislikeable { build(:video) }
  end
end
