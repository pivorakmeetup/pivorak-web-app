RSpec.describe 'Events features -> Read' do
  let!(:event) { create(:event, title: 'Test Event') }

  describe 'COLLECTION' do
    before { visit '/events' }

    context 'unregistered user' do
      it { expect(page).to have_link 'Test Event' }
      it { expect(page).to_not have_link 'New Event' }
    end

    context 'registred user' do
      before { assume_logged_in }

      it { expect(page).to have_link 'Test Event' }
      it { expect(page).to_not have_link 'New Event' }
    end

    context 'admin user' do
      before { assume_admin_logged_in }

      it { expect(page).to have_link 'Test Event' }
      it { expect(page).to have_link 'New Event' }
      it 'New Event click redirect to #new' do
        click_link 'New Event'
        expect(page).to have_current_path('/events/new')
      end
    end
  end

  describe 'SINGLE' do
    before { visit '/events/test-event' }

    context 'unregistered user' do
      it { expect(page).to have_content 'Test Event' }
      it { expect(page).to_not have_link 'Edit Event' }
    end

    context 'registred user' do
      before { assume_logged_in }

      it { expect(page).to have_content 'Test Event' }
      it { expect(page).to_not have_link 'Edit Event' }
    end

    context 'admin user' do
      before { assume_admin_logged_in }

      it { expect(page).to have_content 'Test Event' }
      it { expect(page).to have_link 'Edit Event' }
      it 'Edit Event click redirect to #new' do
        click_link 'Edit Event'
        expect(page).to have_current_path('/events/test-event/edit')
      end
    end
  end
end
