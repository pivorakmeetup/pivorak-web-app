# frozen_string_literal: true

RSpec.describe 'Groups DESTROY' do
  before do
    create(:group, name: 'TestGroup')

    assume_admin_logged_in
    visit '/admin/groups'
  end

  describe 'Destroy' do
    it 'displays the group' do
      expect(page).to have_content 'TestGroup'
    end

    it 'destroys the group', :aggregate_failures do
      click_link 'Destroy'

      expect(page).to have_current_path '/admin/groups'
      expect(page).not_to have_content 'TestGroup'
    end
  end
end
