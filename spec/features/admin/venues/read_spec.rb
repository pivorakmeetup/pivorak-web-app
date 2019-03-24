# frozen_string_literal: true

RSpec.describe 'Venues READ' do
  let!(:venue_a) { create(:venue, name: 'Test Venue A') }
  let!(:venue_b) { create(:venue, name: 'Test Venue B') }

  before do
    assume_admin_logged_in
    visit '/admin/venues'
  end

  it { expect(page).to have_link 'Test Venue A' }
  it { expect(page).to have_link 'Test Venue B' }
  it { expect(page).to have_link 'New Venue' }
  it { expect(page).to have_link('Edit', count: 2) }
  it 'New Venue click redirect to #new' do
    click_link 'New Venue'
    expect(page).to have_current_path('/admin/venues/new')
  end
end
