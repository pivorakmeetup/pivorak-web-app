RSpec.describe 'Event features' do
  let(:event) { create(:event, title: 'Test Event') }

  describe 'CREATE' do
    before do
      visit '/events'
      click_link 'New Event'
    end

    it 'redirect to new path' do
      expect(page).to have_current_path '/events/new'
    end

    context 'invalid input' do
      it 'validates errors' do
        fill_in 'Title',  with: ''
        fill_in 'Agenda', with: ''
        click_button 'Create Event'

        expect_an_error event_title:  :blank
        expect_an_error event_agenda: :blank
      end
    end

    context 'valid input' do
      it 'create new event' do
        fill_in 'Title',  with: 'Super New Event'
        fill_in 'Agenda', with: 'Super Agenda'
        click_button 'Create Event'

        expect(page).to have_current_path '/events/super-new-event'
      end
    end
  end

  describe 'READ' do
    it 'show event' do
      event
      visit '/events/test-event'
      expect(page).to have_content 'Test Event'
    end
  end

  describe 'UPDATE' do
    before do
      event
      visit '/events/test-event'
      click_link 'Edit'
    end

    it 'redirect to edit path' do
      expect(page).to have_current_path '/events/test-event/edit'
    end

    context 'invalid input' do
      it 'validates errors' do
        fill_in 'Title',  with: ''
        fill_in 'Agenda', with: ''
        click_button 'Update Event'

        expect_an_error event_title:  :blank
        expect_an_error event_agenda: :blank
      end
    end

    context 'valid input' do
      it 'create new event' do
        fill_in 'Title',  with: 'Super New Event'
        fill_in 'Agenda', with: 'Super Agenda'
        click_button 'Update Event'

        expect(page).to have_current_path '/events/test-event'
        expect(page).to have_content 'Super New Event'
        expect(page).to have_content 'Super Agenda'
      end
    end
  end
end
