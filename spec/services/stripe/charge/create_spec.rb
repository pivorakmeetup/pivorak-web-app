# frozen_string_literal: true

require 'stripe_mock'
require 'services/stripe/stripe_response_shared_group'

RSpec.describe ::Stripe::Charge::Create do
  describe '.call' do
    it_behaves_like 'Stripe response', :new_charge do
      subject(:create_stripe_charge) { described_class.call(params) }

      context 'when provided with valid params' do
        let(:params) { build(:valid_charge).merge(customer: double) }

        it 'returns valid Stripe::Charge instance', :aggregate_failures do
          expect(create_stripe_charge).to be_an_instance_of Stripe::Charge

          expect(create_stripe_charge.currency).to eq 'UAH'
          expect(create_stripe_charge.amount).to eq params[:amount].to_i * 100
          expect(create_stripe_charge.description).to eq params[:description]
          expect(create_stripe_charge.customer).to eq params[:customer]
        end
      end
    end
  end
end
