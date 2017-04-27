require 'rails_helper'

describe Liqpay::Request::Base do
  let(:user_id) { 1 }

  subject { described_class.(user_id: user_id) }

  describe '#call' do
    context 'getting data for response' do
      let(:data) { subject.data }

      it { expect(data.class).to be String }
    end

    context 'getting signature for response' do
      let(:signature) { subject.signature }

      it { expect(signature.class).to be String }
    end

    context 'getting url for response' do
      let(:url) { subject.url }

      it { expect(url.class).to be String }
      it { expect(url.include?('http')).to be true }
    end
  end
end
