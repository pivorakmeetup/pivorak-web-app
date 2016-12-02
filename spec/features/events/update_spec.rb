RSpec.describe 'Events features -> Update' do
  let!(:event)          { create(:event, title: 'Test Event') }
  let(:test_edit_path) { '/events/test-event/edit' }

  describe 'ACCESS' do
    context 'unregistered user' do
      before { visit test_edit_path }

      it { expect(page).to have_current_path '/' }
    end

    context 'registred user' do
      before do
        assume_logged_in
        visit test_edit_path
      end

      it { expect(page).to have_current_path '/' }
    end

    context 'admin user' do
      before do
        assume_admin_logged_in
        visit test_edit_path
      end

      it { expect(page).to have_current_path test_edit_path }
    end
  end

  describe 'UPDATE' do
    before do
      assume_admin_logged_in
      visit test_edit_path
    end

    it 'redirect to edit path' do
      expect(page).to have_current_path test_edit_path
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
