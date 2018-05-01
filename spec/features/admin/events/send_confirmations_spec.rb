RSpec.describe 'Events SEND CONFIRMATIONS' do
  let!(:event) { create(:event, status: :confirmation) }
  let!(:visit_request) { create(:visit_request, event: event, status: VisitRequest::APPROVED, waiting_list: false) }

  before do
    assume_admin_logged_in(supervisor: true)
    visit "/admin/events/#{event.slug}/edit"
  end

  it { expect(page).to have_link 'Send Confirmations' }

  context 'send emails' do
    after { click_link 'Send Confirmations' }

    it { expect(Event::SendConfirmations).to receive(:call).with(event) }
    it { expect(VisitRequestMailer).to receive_message_chain(:confirmation, :deliver_later) }
  end
end
