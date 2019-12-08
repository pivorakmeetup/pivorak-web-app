# frozen_string_literal: true

RSpec.describe ::Donate::WebhookController do
  describe 'POST /donate/webhook' do
    subject(:do_request) do
      post :create, params: { { amount: 5, currency: 'USD', clientName: 'John Doe' }.to_json => 'none' }
    end

    it 'saves donation into database with payload without ' do
      allow(Donate::SendNewDonateNotification).to receive(:call)

      do_request

      expect(Donate::SendNewDonateNotification).to have_received(:call).with(
        amount: 5, currency: 'USD', clientName: 'John Doe'
      )
    end
  end
end
