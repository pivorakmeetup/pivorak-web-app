RSpec.describe 'Events SEND CONFIRMATIONS' do
  let!(:event) { create(:event, status: :confirmation) }

  before do
    assume_admin_logged_in
    visit "/admin/events/#{event.slug}/edit"
  end

  it { expect(page).to have_link 'Send Confirmations' }

  it 'send emails' do
    expect(Event::SendConfirmations).to receive(:call).with(event)

    click_link 'Send Confirmations'
  end
end
