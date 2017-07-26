RSpec.describe 'Donations READ' do
  let!(:event_a) { create(:donation, user_id: 1, amount: 100) }
  let!(:event_b) { create(:donation, user_id: 1) }

  before do
    assume_admin_logged_in
    visit '/admin/donations'
  end

  it { expect(page).to have_content 'Donations' }
  it { expect(page).to have_content 'Donator' }
  it { expect(page).to have_content 'Amount' }
  it { expect(page).to have_content 'Date' }
  it { expect(page).to have_link 'Admin' }
end
