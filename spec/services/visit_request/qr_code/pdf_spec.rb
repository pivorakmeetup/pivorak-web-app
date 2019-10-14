# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::QrCode::Pdf do
  let(:visit_request) { create(:visit_request) }

  subject(:service) { described_class.new(visit_request) }

  describe '#call' do
    subject(:call) { service.call }

    before do
      # This is a workaround to have the same token.
      # We can't pass token directly as it is created by database.
      allow(visit_request).to receive(:token).and_return('test-token')
    end

    it 'returns PDF file with QR code' do
      expect(call).to eq(File.read('spec/fixtures/pdfs/visit_request_qr_code.pdf'))
    end
  end
end
