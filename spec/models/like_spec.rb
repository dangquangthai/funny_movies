require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '.validations' do
    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:likeable) }

    it do
      subject = create(:like)
      should validate_uniqueness_of(:user_id)
        .scoped_to([:likeable_type, :likeable_id])
        .with_message('Video has already been liked')
    end
  end

  describe '.associations' do
    it { should belong_to(:user) }

    it { should belong_to(:likeable) }
  end
end
