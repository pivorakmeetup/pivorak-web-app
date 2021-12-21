# frozen_string_literal: true

RSpec.describe 'Events CREATE' do
  before do
    assume_admin_logged_in
    visit '/admin/venues/new'
  end

  context 'when invalid input' do
    it 'validates errors' do
      fill_in 'Name', with: ''
      click_button 'Create Venue'

      expect_an_error venue_name: :blank
      expect_error_flash_message 'Venue', 'created'
    end
  end

  context 'when valid input' do
    it 'create new venue' do
      fill_in 'Name', with: 'Secret New Venue'
      fill_in 'Address',  with: 'Some Place'
      fill_in 'Map url',  with: 'https://goo.gl/maps/LkLW5YkNzNL2'
      click_button 'Create Venue'

      expect_success_flash_message 'Venue', 'created'
      expect(page).to have_current_path '/admin/venues/secret-new-venue/edit'
    end
  end
end
