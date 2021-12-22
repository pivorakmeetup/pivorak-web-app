# frozen_string_literal: true

RSpec.describe 'Events UPDATE' do
  let(:test_edit_path) { '/admin/events/test-event/edit' }

  before do
    create(:event, title: 'Test Event')

    assume_admin_logged_in(supervisor: true)
    visit test_edit_path
  end

  context 'when invalid input' do
    it 'validates errors' do
      fill_in 'Title', with: ''
      click_button 'Update Event'

      expect_an_error event_title: :blank
      expect_error_flash_message 'Event', 'updated'
    end
  end

  context 'when valid input' do
    it 'updates event' do
      fill_in 'Title', with: 'Super New Event'
      click_button 'Update Event'

      expect_success_flash_message 'Event', 'updated'
      expect(page).to have_current_path '/admin/events/test-event/edit'
    end
  end

  context 'with default values for event' do
    it 'shows updated values instead of default', :aggregate_failures do
      fill_in 'Title', with: 'Super New Event'
      fill_in 'Limit total', with: 2
      fill_in 'Limit verified', with: 1
      click_button 'Update Event'

      expect_success_flash_message 'Event', 'updated'
      expect(page).to have_field('Limit total', with: '2')
      expect(page).to have_field('Limit verified', with: '1')
    end
  end
end
