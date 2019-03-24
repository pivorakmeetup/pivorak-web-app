# frozen_string_literal: true

RSpec.describe 'Friends READ' do
  let!(:friend_a) { create(:friend, name: 'Test Friend A') }
  let!(:friend_b) { create(:friend, name: 'Test Friend B') }

  before do
    assume_admin_logged_in
    visit '/admin/friends'
  end

  it { expect(page).to have_content 'Test Friend A' }
  it { expect(page).to have_content 'Test Friend B' }
  it { expect(page).to have_link 'New Friend' }
  it { expect(page).to have_link('Edit', count: 2) }
  it 'New Friend click redirect to #new' do
    click_link 'New Friend'
    expect(page).to have_current_path('/admin/friends/new')
  end
end
