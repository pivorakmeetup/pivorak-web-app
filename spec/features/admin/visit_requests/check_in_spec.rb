# frozen_string_literal: true

RSpec.describe 'Visit Requests Check In' do
  subject { page }
  let(:page_url) { "/admin/visit_request/#{visit_request_token}/check_in" }

  let(:visit_request_token) { visit_request.reload.token }
  let!(:event) { create(:event, title: 'Pivorak #1') }
  let(:user) { create(:user, first_name: 'Ivan', last_name: 'Syla') }

  before do
    assume_admin_logged_in(supervisor: true)
    visit page_url
  end

  context 'when visit request not found' do
    let(:visit_request_token) { 'dummy' }

    it { expect(page).to have_content 'Not Found' }
  end

  context 'when visit request already checked in' do
    let(:visit_request) { create(:visit_request, :approved, :visited, event: event, user: user) }

    it { expect(page).to have_content 'Already checked in' }
  end

  context 'when confirmed visit request found' do
    let(:visit_request) { create(:visit_request, :confirmed, event: event, user: user) }

    it { expect(page).to have_content user.full_name }
    it { expect(page).to have_content event.title }
  end
end
