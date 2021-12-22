# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::Confirm do
  let(:confirm_service) { described_class.new(visit_request) }

  let(:visit_request) { create(:visit_request) }

  describe '#call' do
    it 'sets approved status', :aggregate_failures do
      mailer = instance_spy('mail', deliver_later: nil)
      allow(VisitRequestMailer).to receive(:attendance_confirmed).with(visit_request).and_return(mailer)

      confirm_service.call

      expect(mailer).to have_received(:deliver_later)
      expect(VisitRequestMailer).to have_received(:attendance_confirmed).with(visit_request)
      expect(visit_request.reload).to be_confirmed
    end
  end
end
