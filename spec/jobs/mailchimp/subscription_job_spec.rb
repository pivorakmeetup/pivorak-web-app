# frozen_string_literal: true

RSpec.describe ::Mailchimp::SubscriptionJob, type: :job do
  let(:user)    { create(:user) }
  let(:service) { class_spy(::Mailchimp::User::Subscribe).as_stubbed_const }

  describe '#perform' do
    before { allow(service).to receive(:call).with(user: user) }

    context 'with no user id provided' do
      it 'stops execution and returns' do
        described_class.perform_later(nil)

        expect(service).not_to have_received(:call).with(user: user)
      end
    end

    context 'with user id provided' do
      it 'enqueues a job if user has been found' do
        expect { described_class.perform_later(user.id) }.to change(active_jobs, :size).by(1)
      end

      it 'returns if user is not subscribed' do
        allow(user).to receive(:subscribed).and_return(false)

        described_class.perform_later(user.id)

        expect(service).not_to have_received(:call).with(user: user)
      end

      it 'calls subscription service' do
        described_class.perform_now(user.id)

        expect(service).to have_received(:call).with(user: user)
      end
    end
  end
end
