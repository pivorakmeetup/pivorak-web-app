# frozen_string_literal: true

RSpec.describe 'Visit Requests APPROVE' do
  subject(:visit_request_approve) do
    visit "/admin/events/#{event.slug}/visit_requests"
  end

  let(:event) { create(:event) }
  let!(:visit_request) { create(:visit_request, event: event) }
  let!(:visit_request2) { create(:visit_request, event: event) }

  before do
    assume_admin_logged_in(supervisor: true)
  end

  it { expect { visit_request_approve }.not_to raise_error }

  describe 'real time update elements' do
    before { visit_request_approve }

    context 'with valid event id' do
      it { expect(page).to have_css('h2#event[data-event-id]') }
      it { expect(page.find('h2#event')['data-event-id']).to eq event.id.to_s }
    end

    context 'with valid visit requests ids' do
      it { expect(page).to have_css('table#visit-requests') }
      it { expect(page).to have_css("tr#visit-request-#{visit_request.id}") }
      it { expect(page).to have_css("tr#visit-request-#{visit_request2.id}") }
    end
  end
end
