RSpec.describe ::Donate::WebhookController do
  def strong_params(wimpy_params)
    ActionController::Parameters.new(wimpy_params).permit!
  end

  describe 'POST /donate/webhook' do
    subject(:do_request) do
      post :create, params: {amount: 5, currency: 'USD', clientName: 'John Doe'}
    end

    it 'saves donation into database with payload without ' do
      allow(Donate::SendNewDonateNotification).to receive(:call)

      do_request

      expect(Donate::SendNewDonateNotification).to have_received(:call).with(
        strong_params(amount: "5", currency: 'USD', clientName: 'John Doe')
      )
    end
  end
end
