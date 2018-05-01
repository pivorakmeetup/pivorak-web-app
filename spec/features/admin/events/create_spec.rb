RSpec.describe 'Events CREATE' do
  before do
    assume_admin_logged_in(supervisor: true)
    visit '/admin/events/new'
  end

  context 'dateTime inputs' do
    let(:default_started_at_hour)  { Ez::Settings[:app, :events, :default_started_at_hours].to_i }
    let(:default_finished_at_hour) { Ez::Settings[:app, :events, :default_finished_at_hours].to_i }

    it 'should have default values' do
      expect(
        Time.zone.parse(
          find("#event_started_at").value
        ).hour
      ).to eq(default_started_at_hour)

      expect(
        Time.zone.parse(
          find("#event_finished_at").value
        ).hour
      ).to eq(default_finished_at_hour)
    end
  end

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title',  with: ''
      click_button 'Create Event'

      expect_an_error event_title: :blank
      expect_error_flash_message 'Event', 'created'
    end
  end

  context 'valid input' do
    let!(:venue) { create(:venue) }

    it 'create new event' do
      fill_in 'Title', with: 'Super New Event'
      click_button 'Create Event'

      expect_success_flash_message 'Event', 'created'
      expect(page).to have_current_path '/admin/events/super-new-event/edit'
    end

    it 'creates event with image' do
      fill_in 'Title',  with: 'Super New Event'
      attach_file('event[cover]', Rails.root + 'spec/fixtures/images/pivorak.png')

      click_button 'Create Event'

      expect(Event.last.cover).to be_present
    end

    it 'creates event with venue' do
      visit '/admin/events/new'

      fill_in 'Title',  with: 'Super New Event'
      select(venue.name, from: 'Venue')

      click_button 'Create Event'

      expect(Event.last.venue_id).to be_present
    end

    it 'creates event with facebook embeded post code' do
      visit '/admin/events/new'
      fill_in 'Title',  with: 'Super New Event'
      fill_in 'Facebook embeded post',  with: 'http://facebook.com'

      click_button 'Create Event'

      expect(Event.last.facebook_embeded_post).to be_present
    end
  end

  context 'Limit inputs' do
    let(:default_limit_total)      { Ez::Settings[:app, :events, :default_limit] }
    let(:default_limit_verified)   { Ez::Settings[:app, :events, :default_limit_verified] }

    it 'should have default values' do
      expect(page).to have_field('Limit total', with: default_limit_total)
      expect(page).to have_field('Limit verified', with: default_limit_verified)
    end

    it 'should show defined values after creation' do
      fill_in 'Title', with: 'Super New Event'
      fill_in 'Limit total', with: 2
      fill_in 'Limit verified', with: 1
      click_button 'Create Event'

      expect(page).to have_field('Limit total', with: 2)
      expect(page).to have_field('Limit verified', with: 1)
    end
  end
end
