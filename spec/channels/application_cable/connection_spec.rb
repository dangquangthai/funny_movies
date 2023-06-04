require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  describe '#connect' do
    let(:user) { build_stubbed(:user) }
    let(:env)  { instance_double('env') }

    before do
      allow_any_instance_of(ApplicationCable::Connection).to receive(:env).and_return(env)
    end

    context 'with a verified user' do
      let(:warden)  { instance_double('warden', user: user) }

      before do
        allow(env).to receive(:[]).with('warden').and_return(warden)
      end

      it 'successfully connects' do
        connect '/cable'
        expect(connect.current_user).to eq(user)
      end

    end

    context 'without a verified user' do
      let(:warden)  { instance_double('warden', user: nil) }

      before do
        allow(env).to receive(:[]).with('warden').and_return(warden)
      end

      it 'set current user to nil' do
        expect {
          connect '/cable'
        }.to raise_error(ActionCable::Connection::Authorization::UnauthorizedError)
      end
    end
  end
end
