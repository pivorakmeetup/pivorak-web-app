# frozen_string_literal: true

RSpec.describe 'Groups READ' do
  let!(:group_a) { create(:group, name: 'GeneralGroup',   resource: 'Talk') }
  let!(:group_b) { create(:group, name: 'SecondaryGroup', resource: 'Talk') }

  before do
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
