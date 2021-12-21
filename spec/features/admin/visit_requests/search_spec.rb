# frozen_string_literal: true

RSpec.describe 'Visit Requests SEARCH' do
  let(:event) { create(:event) }
  let!(:visit_request) { create(:visit_request, user: user1, event: event) }
  let!(:visit_request2) { create(:visit_request, user: user2, event: event) }
  let(:user1) { create(:user, first_name: 'Den', last_name: 'Med') }
  let(:user2) { create(:user, first_name: 'Ivan', last_name: 'Chai') }

  before do
    assume_admin_logged_in(supervisor: true)
    visit "/admin/events/#{event.slug}/visit_requests"
  end

  it 'finds visit request by first name', :aggregate_failures do
    fill_in 'query', with: user1.first_name
    click_on I18n.t('words.search')

    expect(page).to have_content user1.full_name
    expect(page).not_to have_content user2.full_name
  end

  it 'finds visit request by last name', :aggregate_failures do
    fill_in 'query', with: user2.last_name
    click_on I18n.t('words.search')

    expect(page).to have_content user2.full_name
    expect(page).not_to have_content user1.full_name
  end
end
