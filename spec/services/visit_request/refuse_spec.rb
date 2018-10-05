require 'rails_helper'

describe VisitRequest::Refuse do
  let(:visit_request) { create(:visit_request) }

  subject do
    described_class.new(visit_request)
  end

  describe '#call' do
    it 'sets refused status' do
      subject.call

      expect(visit_request.reload.status).to eq(VisitRequest::REFUSED.to_s)
    end
  end
end
