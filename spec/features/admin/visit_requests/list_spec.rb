# frozen_string_literal: true

RSpec.describe 'Visit Requests APPROVE' do
  let(:event) { create(:event) }
  let!(:visit_request) { create(:visit_request, event: event) }
  let!(:visit_request_2) { create(:visit_request, event: event) }

  before do
    assume_admin_logged_in(supervisor: true)
  end

  subject do
    visit "/admin/events/#{event.slug}/visit_requests"
  end

  it { expect { subject }.to_not raise_error }

  describe 'real time update elements' do
    before { subject }

    context 'valid event id' do
      it { expect(page).to have_css('h2#event[data-event-id]') }
      it { expect(page.find('h2#event')['data-event-id']).to eq event.id.to_s }
    end

    context 'valid visit requests ids' do
      it { expect(page).to have_css('table#visit-requests') }
      it { expect(page).to have_css("tr#visit-request-#{visit_request.id}") }
      it { expect(page).to have_css("tr#visit-request-#{visit_request_2.id}") }
    end
  end
end
