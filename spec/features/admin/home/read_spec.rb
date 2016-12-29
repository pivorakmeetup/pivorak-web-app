RSpec.describe 'Home READ' do
  before do
    assume_admin_logged_in
    visit '/admin'
  end

  it { expect(page).to have_link 'Admin' }
  it { expect(page).to have_link 'Events' }
  it { expect(page).to have_link 'Talks' }
  it { expect(page).to have_link 'Venues' }
  it { expect(page).to have_link 'Goals' }
  it { expect(page).to have_link 'Members' }
  it { expect(page).to have_link 'Groups' }
  it { expect(page).to have_link 'App' }
end
