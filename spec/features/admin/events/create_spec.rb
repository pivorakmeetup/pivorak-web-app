RSpec.describe 'Events CREATE' do
  before do
    assume_admin_logged_in
    visit '/admin/events/new'
  end

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title',  with: ''
      click_button 'Create Event'

      expect_an_error event_title:  :blank
    end
  end

  context 'valid input' do
    it 'create new event' do
      fill_in 'Title',  with: 'Super New Event'
      click_button 'Create Event'

      expect(page).to have_current_path '/events/super-new-event'
    end

    it 'creates event with image' do
      fill_in 'Title',  with: 'Super New Event'
      attach_file('event[cover]', Rails.root + 'spec/fixtures/images/pivorak.png')

      click_button 'Create Event'

      expect(Event.last.cover).to be_present
    end
  end
end
