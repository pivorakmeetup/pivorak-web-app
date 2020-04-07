# frozen_string_literal: true

RSpec.describe ::Mailchimp::SubscriptionJob, type: :job do
  let(:user)    { create(:user) }
  let(:service) { ::Mailchimp::User::Subscribe }

  before do
    allow_any_instance_of(service).to receive(:call).and_return(nil)
  end

  describe '#perform' do
    context 'with no user id provided' do
      it 'stops execution and returns' do
        expect(service).not_to receive(:call).with(user: user)
        described_class.perform_later(nil)
      end
    end

    context 'with user id provided' do
      it 'enqueues a job if user has been found' do
        expect { described_class.perform_later(user.id) }.to change(active_jobs, :size).by(1)
      end

      it 'returns if user is not subscribed' do
        allow(user).to receive(:subscribed).and_return(false)
        expect(service).not_to receive(:call).with(user: user)
        described_class.perform_later(user.id)
      end

      it 'calls subscription service' do
        expect(service).to receive(:call).with(user: user)
        described_class.perform_now(user.id)
      end
    end
  end
end
