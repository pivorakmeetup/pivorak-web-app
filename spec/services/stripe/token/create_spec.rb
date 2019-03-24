# frozen_string_literal: true

require 'stripe_mock'
require 'services/stripe/stripe_response_shared_group'

RSpec.describe ::Stripe::Token::Create do
  describe '.call' do
    it_behaves_like 'Stripe response', :create_token do
      subject { described_class.call(params) }

      context 'when provided with valid params' do
        let(:params) { build(:valid_credit_card) }

        it 'returns valid Stripe::Token instance' do
          expect(subject).to be_an_instance_of Stripe::Token

          expect(subject.id).not_to be_nil
          expect(subject.type).not_to be_nil
        end
      end
    end
  end
end
