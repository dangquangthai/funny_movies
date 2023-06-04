require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive.with_message('has already been taken') }

    it { should allow_value("email@addresse.foo").for(:email) }
    it { should_not allow_value("foo").for(:email).with_message('must be a valid email address') }

    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end

  describe '.associations' do
    it { should have_many(:videos).dependent(:destroy) }

    it { should have_many(:notifications).dependent(:destroy) }
  end
end
