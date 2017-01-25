RSpec.describe 'Events UPDATE' do
  let!(:event)          { create(:event, title: 'Test Event') }
  let(:test_edit_path) { '/admin/events/test-event/edit' }

  before do
    assume_admin_logged_in
    visit test_edit_path
  end

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title',  with: ''
      click_button 'Update Event'

      expect_an_error event_title:  :blank
      expect_error_flash_message 'Event', 'updated'
    end
  end

  context 'valid input' do
    it 'updates event' do
      fill_in 'Title',  with: 'Super New Event'
      click_button 'Update Event'

      expect_success_flash_message 'Event', 'updated'
      expect(page).to have_current_path '/admin/events/test-event/edit'
    end
  end
end
