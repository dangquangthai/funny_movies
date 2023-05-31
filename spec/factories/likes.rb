FactoryBot.define do
  factory :like do
    user { build(:user) }
    likeable { build(:video) }
  end
end
