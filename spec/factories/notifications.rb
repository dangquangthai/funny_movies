FactoryBot.define do
  factory :notification do
    user { build(:user) }
    whodunit { build(:user) }
    action { 'shared_a_video' }
    notifiable { build(:video) }
  end
end
