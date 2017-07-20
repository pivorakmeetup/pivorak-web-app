RSpec.describe 'Visit Requests TOGGLE LIST' do
  let(:event) { create(:event, status: :live) }
  let!(:visit_request) { create(:visit_request, event: event, status: :approved, waiting_list: false) }
  let(:visit_page) { -> { visit "/admin/events/#{event.slug}/visit_requests" } }

  before do
    assume_admin_logged_in
    visit_page.call
  end

  describe 'toggling from one list to another' do
    it { expect(page).to have_link 'Hello!', count: 1 }

    it 'toggle to the main list' do
      click_link 'Hello!'
      visit_page.call

      expect(page).to have_link 'Waiting', count: 1
      expect(page).to_not have_link 'Hello!', count: 1

      click_link 'Waiting'
      visit_page.call

      expect(page).to have_link 'Hello!', count: 1
      expect(page).to_not have_link 'Waiting', count: 1
    end
  end
end
