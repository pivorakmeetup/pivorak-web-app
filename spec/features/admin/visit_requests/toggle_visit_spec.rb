# frozen_string_literal: true

RSpec.describe 'Visit Requests TOGGLE LIST' do
  let(:event) { create(:event, status: :live) }
  let!(:visit_request) { create(:visit_request, event: event, status: :approved, waiting_list: false) }
  let(:visit_page) { -> { visit "/admin/events/#{event.slug}/visit_requests" } }

  before do
    assume_admin_logged_in(supervisor: true)
    visit_page.call
  end

  it 'checking in the visitor' do
    visit_page.call

    expect(page).to have_link I18n.t('visit_request.check_in.plural')
    expect(page).to_not have_content I18n.t('visit_request.check_in.already_checked_in')

    click_link I18n.t('visit_request.check_in.plural')

    expect(visit_request.reload.checked_in_at).to be_present
  end
end
