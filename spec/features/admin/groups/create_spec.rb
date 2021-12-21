# frozen_string_literal: true

RSpec.describe 'Groups CREATE' do
  before do
    assume_admin_logged_in
    visit '/admin/groups/new'
  end

  context 'when invalid input' do
    it 'validates presence' do
      fill_in 'Name', with: ''
      click_button 'Create Group'

      expect_an_error group_name:     :blank
      expect_an_error group_resource: :blank
    end
  end

  context 'when valid input' do
    it 'create new group' do
      fill_in 'Name', with: 'SuperGroup'
      select  'Talk', from: 'group_resource'
      click_button 'Create Group'

      expect(page).to have_current_path '/admin/groups'
      expect(page).to have_content 'SuperGroup'
      expect(page).to have_content 'Talk'
    end
  end
end
