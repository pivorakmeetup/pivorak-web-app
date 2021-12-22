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
    after { click_link 'Send Confirmations' }

    it { expect(Event::SendConfirmations).to receive(:call).with(event) }
    it { expect(VisitRequestMailer).to receive_message_chain(:confirmation, :deliver_later) }
  end

  describe 'Send Confirmation Reminders' do
    after { click_link 'Send Confirmation Reminders' }

    it { expect(Event::SendConfirmationReminders).to receive(:call).with(event) }
    it { expect(VisitRequestMailer).to receive_message_chain(:confirmation_reminder, :deliver_later) }
  end
end
