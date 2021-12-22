# frozen_string_literal: true

RSpec.describe ::Donate::WebhookController do
  describe 'POST /donate/webhook' do
    subject(:do_request) do
      post :create, params: { donation_data.to_json => 'none' }
    end

    let(:donation_data) { { amount: 5, currency: 'USD', clientName: 'John Doe', transactionStatus: 'Approved' } }

    it 'saves donation into database with' do
      allow(Donate::SendNewDonateNotification).to receive(:call)

      do_request

      expect(Donate::SendNewDonateNotification).to have_received(:call).with(donation_data)
    end
  end
end
