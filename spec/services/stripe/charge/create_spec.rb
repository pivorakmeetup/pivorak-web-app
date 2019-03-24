# frozen_string_literal: true

require 'stripe_mock'
require 'services/stripe/stripe_response_shared_group'

RSpec.describe ::Stripe::Charge::Create do
  describe '.call' do
    it_behaves_like 'Stripe response', :new_charge do
      subject { described_class.call(params) }

      context 'when provided with valid params' do
        let(:params) { build(:valid_charge).merge(customer: double) }

        it 'returns valid Stripe::Charge instance' do
          expect(subject).to be_an_instance_of Stripe::Charge

          expect(subject.currency).to eq 'UAH'
          expect(subject.amount).to eq params[:amount].to_i * 100
          expect(subject.description).to eq params[:description]
          expect(subject.customer).to eq params[:customer]
        end
      end
    end
  end
end
