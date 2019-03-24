# frozen_string_literal: true

RSpec.describe 'Groups DESTROY' do
  let!(:group) { create(:group, name: 'TestGroup') }

  before do
    assume_admin_logged_in
    visit '/admin/groups'
  end

  describe 'Destroy' do
    it 'displays the group' do
      expect(page).to have_content 'TestGroup'
    end

    it 'destroys the group' do
      click_link 'Destroy'

      expect(page).to have_current_path '/admin/groups'
      expect(page).to_not have_content 'TestGroup'
    end
  end
end
