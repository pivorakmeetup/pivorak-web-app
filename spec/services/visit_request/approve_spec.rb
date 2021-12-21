# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::Approve do
  subject do
    described_class.new(visit_request)
  end

  let(:visit_request) { create(:visit_request) }

  describe '#call' do
    it 'sets approved status', :aggregate_failures do
      mailer = instance_double('mail')
      expect(VisitRequestMailer).to receive(:approved).with(visit_request) { mailer }
      expect(mailer).to receive(:deliver_later)

      subject.call

      expect(visit_request.reload.status).to eq(VisitRequest::APPROVED.to_s)
    end
  end
end
