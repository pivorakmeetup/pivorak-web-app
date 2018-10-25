require 'rails_helper'

describe Event::SendConfirmationReminders do
  subject(:service) { described_class.new(event) }
  let(:event) { create(:event) }

  describe '#call' do
    subject(:call) { service.call }

    let!(:approved_request) { create(:visit_request, :approved, event: event) }
    let(:last_job) { active_jobs.last }
    before do
      create(:visit_request, :confirmed, event: event)
      create(:visit_request, :refused, event: event)
      create(:visit_request, :approved)
    end

    it 'sends confirmation reminders to people who did not confirm their attendance' do
      allow(VisitRequestMailer).to receive(:confirmation_reminder).with(approved_request).and_call_original

      call

      expect(VisitRequestMailer).to have_received(:confirmation_reminder).once

      expect(active_jobs.size).to eq(1)
      expect(last_job[:job]).to eq ActionMailer::DeliveryJob
      expect(last_job[:args][0]).to eq 'VisitRequestMailer'
      expect(last_job[:args][1]).to eq 'confirmation_reminder'
    end
  end
end
