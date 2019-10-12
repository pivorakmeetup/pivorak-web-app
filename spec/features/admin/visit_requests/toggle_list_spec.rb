# frozen_string_literal: true

RSpec.describe 'Visit Requests TOGGLE LIST' do
  let(:event) { create(:event) }
  let!(:visit_request) { create(:visit_request, event: event, waiting_list: true) }
  let(:visit_page) { -> { visit "/admin/events/#{event.slug}/visit_requests" } }

  before do
    assume_admin_logged_in(supervisor: true)
    visit_page.call
  end

  describe 'toggling from one list to another' do
    it { expect(page).to have_link 'Waiting', count: 1 }

    it 'toggle to the main list' do
      click_link 'Waiting'
      visit_page.call

      expect(page).to have_link 'Main', count: 1
      expect(page).not_to have_link 'Waiting', count: 1

      click_link 'Main'
      visit_page.call

      expect(page).to have_link 'Waiting', count: 1
      expect(page).not_to have_link 'Main', count: 1
    end
  end
end
