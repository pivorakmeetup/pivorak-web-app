# frozen_string_literal: true

require 'stripe_mock'
require 'services/stripe/stripe_response_shared_group'

RSpec.describe ::Stripe::Customer::Create do
  describe '.call' do
    it_behaves_like 'Stripe response', :new_customer do
      subject { described_class.call(params) }

      context 'when provided with valid params' do
        let(:helper) { StripeMock.create_test_helper }
        let(:params) { build(:valid_customer).merge(card: helper.generate_card_token) }

        it 'returns valid Stripe::Customer instance', :aggregate_failures do
          expect(subject).to be_an_instance_of Stripe::Customer

          expect(subject.id).not_to be_nil
          expect(subject.email).to eq params[:email]
        end
      end
    end
  end
end
