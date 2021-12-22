# frozen_string_literal: true

RSpec.describe 'Events SEND CONFIRMATIONS' do
  let(:event) { create(:event, status: :confirmation) }

  before do
    create(:visit_request, event: event, status: VisitRequest::APPROVED, waiting_list: false)

    assume_admin_logged_in(supervisor: true)
    visit "/admin/events/#{event.slug}/edit"
  end

  it { expect(page).to have_link 'Send Confirmations' }

  describe 'Send Confirmations' do
    it 'calls event send confirmation service' do
      class_spy(Event::SendConfirmations).as_stubbed_const

      click_link 'Send Confirmations'

      expect(Event::SendConfirmations).to have_received(:call).with(event)
    end

    it 'sends and email', :aggregate_failures do
      class_spy(VisitRequestMailer).as_stubbed_const
      mailer = instance_spy('mail')
      allow(VisitRequestMailer).to receive(:confirmation).and_return(mailer)

      click_link 'Send Confirmations'

      expect(VisitRequestMailer).to have_received(:confirmation)
      expect(mailer).to have_received(:deliver_later)
    end
  end

  describe 'Send Confirmation Reminders' do
    it 'calls event send confirmation reminders service' do
      class_spy(Event::SendConfirmationReminders).as_stubbed_const

      click_link 'Send Confirmation Reminders'

      expect(Event::SendConfirmationReminders).to have_received(:call).with(event)
    end

    it 'sends and email', :aggregate_failures do
      class_spy(VisitRequestMailer).as_stubbed_const
      mailer = instance_spy('mail')
      allow(VisitRequestMailer).to receive(:confirmation_reminder).and_return(mailer)

      click_link 'Send Confirmation Reminders'

      expect(VisitRequestMailer).to have_received(:confirmation_reminder)
      expect(mailer).to have_received(:deliver_later)
    end
  end
end
