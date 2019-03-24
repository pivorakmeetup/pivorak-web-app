# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VisitRequest::QrCode::Generate do
  subject(:service) { described_class.new(visit_request) }
  let(:visit_request) { build_stubbed(:visit_request) }

  before do
    allow(VisitRequest::QrCode::Url).to receive(:call).with(visit_request).and_return('http://check-in-url')
  end

  describe '#call' do
    it 'returns qr object' do
      allow(RQRCode::QRCode).to receive(:new)

      described_class.call(visit_request)

      expect(RQRCode::QRCode).to have_received(:new).with('http://check-in-url', level: :h)
    end
  end
end
