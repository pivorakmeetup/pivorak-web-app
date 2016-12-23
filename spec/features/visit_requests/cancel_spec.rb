RSpec.describe 'Visit Requests CANCEL' do
  let(:event) { create(:event) }
  let(:user) { create(:user) }
  let(:visit_request) { create(:visit_request, user: user, event: event) }

  before do
    visit_request
    assume_logged_in(user)

    visit "/events/#{event.slug}"

    click_link I18n.t('visit_requests.cancel_attendace')
  end

  it { expect(page).to have_link I18n.t('visit_requests.attend') }
  it { expect(visit_request.reload.status).to eq(VisitRequest::CANCELED.to_s) }

end
