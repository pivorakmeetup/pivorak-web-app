# frozen_string_literal: true

require 'rails_helper'

describe Event::SendConfirmations do
  subject(:service) { described_class.new(event) }
  let(:event) { create(:event) }

  describe '#call' do
    subject(:call) { service.call }

    let!(:confirmed_request) { create(:visit_request, :confirmed, event: event) }
    let(:last_job) { active_jobs.last }
    before do
      create(:visit_request, :refused, event: event)
      create(:visit_request, :approved)
    end

    it 'sends confirmation reminders to people who did not confirm their attendance' do
      allow(VisitRequestMailer).to receive(:confirmation).with(confirmed_request).and_call_original

      call

      expect(VisitRequestMailer).to have_received(:confirmation).once

      expect(active_jobs.size).to eq(1)
      expect(last_job[:job]).to eq ActionMailer::DeliveryJob
      expect(last_job[:args][0]).to eq 'VisitRequestMailer'
      expect(last_job[:args][1]).to eq 'confirmation'
    end

    it 'uses bulk email sender' do
      allow(BulkEmailSender).to receive(:call)
        .with(mailer_klass: VisitRequestMailer, method_name: :confirmation, scope: [confirmed_request])

      call

      expect(BulkEmailSender).to have_received(:call)
    end
  end
end
