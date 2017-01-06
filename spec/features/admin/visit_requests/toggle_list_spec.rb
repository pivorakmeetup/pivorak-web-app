RSpec.describe 'Visit Requests TOGGLE LIST' do
  let(:event) { create(:event) }
  let!(:visit_request) { create(:visit_request, event: event, waiting_list: true) }

  before do
    assume_admin_logged_in
    visit "/admin/events/#{event.slug}/visit_requests"
  end

  describe 'toggling from one list to another' do
    it { expect(page).to have_link 'Waiting', count: 1 }

    it 'toggle to the main list' do
      click_link 'Waiting'

      expect(page).to have_link 'Main', count: 1
      expect(page).to_not have_link 'Waiting', count: 1

      click_link 'Main'

      expect(page).to have_link 'Waiting', count: 1
      expect(page).to_not have_link 'Main', count: 1
    end
  end
end
