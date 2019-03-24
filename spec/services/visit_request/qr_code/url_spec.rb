# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VisitRequest::QrCode::Url do
  subject(:service) { described_class.new(visit_request) }
  let(:visit_request) { build_stubbed(:visit_request) }

  before do
    allow(visit_request).to receive(:token).and_return('test-token')
  end

  describe '#call' do
    it 'returns URL for check in' do
      expect(described_class.call(visit_request)).to eq('http://localhost/admin/visit_request/test-token/check_in')
    end
  end
end
