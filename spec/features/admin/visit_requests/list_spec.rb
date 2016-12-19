RSpec.describe 'Visit Requests APPROVE' do
  let(:event) { create(:event) }
  let!(:visit_request) { create(:visit_request, event: event) }
  let!(:visit_request_2) { create(:visit_request, event: event) }

  before do
    assume_admin_logged_in
  end

  subject do
    visit "/admin/events/#{event.slug}/visit_requests"
  end

  it { expect{ subject }.to_not raise_error }

end
