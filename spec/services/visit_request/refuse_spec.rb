# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::Refuse do
  let(:refuse_service) { described_class.new(visit_request) }

  let(:visit_request) { create(:visit_request) }

  describe '#call' do
    it 'sets refused status' do
      refuse_service.call

      expect(visit_request.reload.status).to eq(VisitRequest::REFUSED.to_s)
    end
  end
end
