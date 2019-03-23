require 'rails_helper'

describe BulkEmailSender do
  subject(:service) { described_class.new(mailer_klass: VisitRequestMailer, method_name: :confirmation_reminder, scope: VisitRequest.approved) }

  describe '#call' do
    subject(:call) { service.call }

    let!(:approved_request) { create(:visit_request, :approved) }
    let(:last_job) { active_jobs.last }

    it 'sends confirmation reminders to people who did not confirm their attendance' do
      allow(VisitRequestMailer).to receive(:confirmation_reminder).with(approved_request).and_call_original

      call

      expect(VisitRequestMailer).to have_received(:confirmation_reminder).once

      expect(active_jobs.size).to eq(1)
      expect(last_job[:job]).to eq ActionMailer::DeliveryJob
      expect(last_job[:args][0]).to eq 'VisitRequestMailer'
      expect(last_job[:args][1]).to eq 'confirmation_reminder'
    end

    it 'spreads sending through the time' do
      stub_const("BulkEmailSender::BULK_SIZE", 1)

      create(:visit_request, :approved)
      mocked_mailer = double('Dummy', deliver_later: true)

      allow(VisitRequestMailer).to receive(:confirmation_reminder).and_return(mocked_mailer)

      call

      expect(mocked_mailer).to have_received(:deliver_later).with(wait: 0.hour).once
      expect(mocked_mailer).to have_received(:deliver_later).with(wait: 1.hour).once
    end
  end
end
