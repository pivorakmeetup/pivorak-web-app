RSpec.describe 'Events features -> Create' do
  describe 'ACCSESS' do
    context 'unregistered user' do
      before { visit '/events/new' }

      it { expect(page).to have_current_path '/' }
    end

    context 'registred user' do
      before do
        assume_logged_in
        visit '/events/new'
      end

      it { expect(page).to have_current_path '/' }
    end

    context 'admin user' do
      before do
        assume_admin_logged_in
        visit '/events/new'
      end

      it { expect(page).to have_current_path '/events/new' }
    end
  end

  describe 'CREATE' do
    before do
      assume_admin_logged_in
      visit '/events/new'
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
        expect(page).to have_content 'Super New Event'
        expect(page).to have_content 'Super Agenda'
      end
    end
  end
end
