RSpec.describe 'Events READ' do
  let!(:event_a) { create(:event, title: 'Test Event A', status: :confirmation) }
  let!(:event_b) { create(:event, title: 'Test Event B') }

  before do
    assume_admin_logged_in
    visit '/admin/events'
  end

  it { expect(page).to have_link 'Test Event A' }
  it { expect(page).to have_link 'Test Event B' }
  it { expect(page).to have_link 'New Event' }
  it { expect(page).to have_link('Edit', count: 2) }
  it { expect(page).to have_link('Visitors Report', count: 1) }
  it 'New Event click redirect to #new' do
    click_link 'New Event'
    expect(page).to have_current_path('/admin/events/new')
  end
end
