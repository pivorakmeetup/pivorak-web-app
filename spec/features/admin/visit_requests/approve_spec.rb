RSpec.describe 'Visit Requests APPROVE' do
  let(:event) { create(:event) }
  let!(:visit_request) { create(:visit_request, event: event) }

  before do
    assume_admin_logged_in
    visit "/admin/events/#{event.slug}/visit_requests"

    click_link I18n.t('visit_requests.approve')
  end

  it { expect(page).to have_current_path("/admin/events/#{event.slug}/visit_requests") }
  it { expect(page).to_not have_link 'Approve' }
  it { expect(page).to have_link 'Cancel' }
  it { expect(visit_request.reload.status).to eq(VisitRequest::APPROVED.to_s) }
end
