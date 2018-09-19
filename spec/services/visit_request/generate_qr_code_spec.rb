require 'rails_helper'

describe VisitRequest::GenerateQrCode do
  let(:visit_request) { create(:visit_request).reload }

  subject(:service) { described_class.new(visit_request) }

  describe '#call' do
    subject(:call) { service.call }

    it 'returns PDF file with QR code' do
      expect(call).to be_present
    end
  end
end
