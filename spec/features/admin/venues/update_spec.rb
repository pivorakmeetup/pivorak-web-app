# frozen_string_literal: true

RSpec.describe 'Venues UPDATE' do
  let(:test_edit_path) { '/admin/venues/test-venue/edit' }

  before do
    create(:venue, name: 'Test Venue')

    assume_admin_logged_in
    visit test_edit_path
  end

  context 'when invalid input' do
    it 'validates errors' do
      fill_in 'Name', with: ''
      click_button 'Update Venue'

      expect_an_error venue_name: :blank
      expect_error_flash_message 'Venue', 'updated'
    end
  end

  context 'when valid input' do
    it 'create new venue' do
      fill_in 'Name', with: 'Secret New Venue'
      click_button 'Update Venue'

      expect_success_flash_message 'Venue', 'updated'
      expect(page).to have_current_path '/admin/venues/test-venue/edit'
    end
  end
end
