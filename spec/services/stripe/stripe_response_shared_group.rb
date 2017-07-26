require 'stripe_mock'

RSpec.shared_examples 'Stripe response' do |action_hook|
  before  { StripeMock.start }
  after   { StripeMock.stop }

  context 'when provided with invalid params' do
    let(:params) { {} }

    %i(
      incorrect_number
      invalid_number
      invalid_expiry_month
      invalid_expiry_year
      invalid_cvc
      expired_card
      incorrect_cvc
      card_declined
      missing
      processing_error
    ).each do |stripe_error|
      it "raises exception if :#{stripe_error} response-code is returned" do
        StripeMock.prepare_card_error(stripe_error, action_hook)
        expect { subject }.to raise_error(Stripe::CardError)
      end
    end
  end
end
