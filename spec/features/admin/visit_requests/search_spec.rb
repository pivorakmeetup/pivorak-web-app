RSpec.describe 'Visit Requests SEARCH' do
  let(:event) { create(:event) }
  let!(:visit_request) { create(:visit_request, user: user_1, event: event) }
  let!(:visit_request_2) { create(:visit_request, user: user_2, event: event) }
  let(:user_1) { create(:user, first_name: 'Den', last_name: 'Med') }
  let(:user_2) { create(:user, first_name: 'Ivan', last_name: 'Chai') }

  before do
    assume_admin_logged_in(supervisor: true)
    visit "/admin/events/#{event.slug}/visit_requests"
  end


  it 'finds visit request by first name' do
    fill_in 'query', with: user_1.first_name
    click_on I18n.t('words.search')

    expect(page).to have_content user_1.full_name
    expect(page).not_to have_content user_2.full_name
  end

  it 'finds visit request by last name' do
    fill_in 'query', with: user_2.last_name
    click_on I18n.t('words.search')

    expect(page).to have_content user_2.full_name
    expect(page).not_to have_content user_1.full_name
  end
end
