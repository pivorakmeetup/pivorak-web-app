require 'rails_helper'

describe Liqpay::Request::Signature do
  let(:data)         { Liqpay::Request::Base.call.send(:sending_data) }
  let(:request_data) { Liqpay::Request::Data.(data) }
  let(:private_key)  { Liqpay::Request::Base.call.send(:private_key) }

  subject { described_class.(private_key: private_key, request_data: request_data) }

  describe '#call' do
    it { expect(subject.class).to be String }
  end
end
