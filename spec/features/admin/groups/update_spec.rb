# frozen_string_literal: true

RSpec.describe 'Groups UPDATE' do
  let!(:group) { create(:group, name: 'TestGroup') }

  before do
    assume_admin_logged_in
    visit "/admin/groups/#{group.id}/edit"
  end

  context 'invalid input' do
    it 'validates title presence' do
      fill_in 'Name', with: ''
      click_button 'Update Group'

      expect_an_error group_name: :blank
    end
  end

  context 'valid input' do
    it 'create new group' do
      fill_in 'Name', with: 'NewNameForGroup'
      click_button 'Update Group'

      expect(page).to have_current_path '/admin/groups'
      expect(page).to have_content 'NewNameForGroup'
    end
  end
end
