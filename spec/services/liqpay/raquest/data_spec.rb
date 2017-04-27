require 'rails_helper'

describe Liqpay::Request::Data do
  let(:data)         { Liqpay::Request::Base.call.send(:sending_data) }
  let(:encoded_data) { Base64.strict_encode64(data) }

  subject { described_class.(data) }

  describe '#call' do
    it { expect(subject.class).to be String }
    it { expect(subject).to eq encoded_data }
  end
end
