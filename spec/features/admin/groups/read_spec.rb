# frozen_string_literal: true

RSpec.describe 'Groups READ' do
  before do
    create(:group, name: 'GeneralGroup',   resource: 'Talk')
    create(:group, name: 'SecondaryGroup', resource: 'Talk')

    assume_admin_logged_in
    visit '/admin/groups'
  end

  it { expect(page).to have_content 'GeneralGroup' }
  it { expect(page).to have_content 'SecondaryGroup' }
  it { expect(page).to have_link 'New Group' }
  it { expect(page).to have_content('Edit', count: 2) }

  it 'New Group click redirect to #new' do
    click_link 'New Group'
    expect(page).to have_current_path('/admin/groups/new')
  end
end
