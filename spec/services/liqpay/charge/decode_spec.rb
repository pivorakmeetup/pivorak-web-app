require 'rails_helper'

describe Liqpay::Charge::Decode do
  let(:valid_data)           { build :liqpay_valid_response_data }
  let(:valid_encoded_data)   { Base64.encode64(valid_data.to_json) }
  let(:invalid_encoded_data) { false }


  describe '#call' do
    context 'decode valid response' do
      subject { described_class.(valid_encoded_data) }

      it { expect(subject).to be_truthy }
      it { expect(subject.class).to be(Hash) }
    end

    context 'decode invalid response' do
      subject { described_class.(invalid_encoded_data) }

      it { expect(subject).to be_falsey }
    end
  end
end
