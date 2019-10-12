# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::Cancel do
  subject do
    described_class.new(visit_request)
  end

  let(:visit_request) { create(:visit_request) }

  describe '#call' do
    it 'sets canceled status' do
      subject.call

      expect(visit_request.reload.status).to eq(VisitRequest::CANCELED.to_s)
    end
  end
end
