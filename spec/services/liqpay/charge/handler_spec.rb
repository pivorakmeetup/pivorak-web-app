require 'rails_helper'

describe Liqpay::Charge::Handler do
  let(:invalid_response) { false }

  describe '#call' do
    context 'data is not correct' do
      subject { described_class.(invalid_response) }

      it { expect(subject[:status]).to eq(described_class::STATUS_ERROR) }
    end

    context 'response status is success' do
      subject { described_class.(success_response) }

      it { expect(subject[:status]).to eq(described_class::STATUS_SUCCESS) }
    end

    context 'check saving only one uniq payment' do
      before  { described_class.(success_response) }

      subject { described_class.(success_response) }

      it { expect(Donation.count).to eq 1 }
      it { expect(subject[:status]).to eq(described_class::STATUS_SUCCESS) }
      it { expect(Donation.count).to eq 1 }
    end

    context 'user_id saved' do
      let(:response_with_customer) do
        Base64.strict_encode64(
          (build :liqpay_valid_response_data, :customer, payment_id: 999).to_json
        )
      end

      before { described_class.(response_with_customer) }

      it { expect(Donation.last.user_id.class).to be Fixnum }
      it { expect(Donation.last.currency.class).to be String }
    end

    context 'user_id does not saved' do
      before  { described_class.(success_response) }

      it { expect(Donation.first.user_id).to be nil }
    end

    context 'response status is failure' do
      subject { described_class.(error_response) }

      it { expect(subject[:status]).to eq(described_class::STATUS_ERROR) }
    end

    context 'other response status' do
      subject { described_class.(notification_response) }

      it { expect(subject[:status]).to eq(described_class::STATUS_NOTIFICATION) }
    end
  end

  private

  def success_response
    Base64.strict_encode64((build :liqpay_valid_response_data).to_json)
  end

  def error_response
    Base64.strict_encode64((build :liqpay_error_response_data).to_json)
  end

  def notification_response
    Base64.strict_encode64((build :liqpay_notification_response_data).to_json)
  end
end
