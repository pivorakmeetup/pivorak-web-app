# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::Approve do
  let(:visit_request) { create(:visit_request) }

  subject do
    described_class.new(visit_request)
  end

  describe '#call' do
    it 'sets approved status' do
      mailer = instance_double('mail')
      expect(VisitRequestMailer).to receive(:approved).with(visit_request) { mailer }
      expect(mailer).to receive(:deliver_later)

      subject.call

      expect(visit_request.reload.status).to eq(VisitRequest::APPROVED.to_s)
    end
  end
end
