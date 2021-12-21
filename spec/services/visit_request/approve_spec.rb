# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::Approve do
  subject do
    described_class.new(visit_request)
  end

  let(:visit_request) { create(:visit_request) }

  describe '#call' do
    it 'sets approved status', :aggregate_failures do
      mailer = instance_spy('mail', deliver_later: nil)
      allow(VisitRequestMailer).to receive(:approved).with(visit_request).and_return(mailer)

      subject.call

      expect(mailer).to have_received(:deliver_later)
      expect(VisitRequestMailer).to have_received(:approved).with(visit_request)
      expect(visit_request.reload.status).to eq(VisitRequest::APPROVED.to_s)
    end
  end
end
