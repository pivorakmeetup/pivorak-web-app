# frozen_string_literal: true

RSpec.describe 'Members READ' do
  before do
    create(:user, first_name: 'First',  last_name: 'User')
    create(:user, first_name: 'Second', last_name: 'User')

    assume_admin_logged_in(supervisor: true)
    visit '/admin/members'
  end

  it { expect(page).to have_link 'First User' }
  it { expect(page).to have_link 'Second User' }
  it { expect(page).to have_link 'New Member' }
  it { expect(page).to have_link('Edit', count: 3) }

  it 'New Member click redirect to #new' do
    click_link 'New Member'
    expect(page).to have_current_path('/admin/members/new')
  end
end
