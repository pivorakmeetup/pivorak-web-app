require 'rails_helper'

RSpec.describe User::EventApplied do
  let!(:visitor_approved) { create(:user) }
  let!(:visitor_pending) { create(:user) }
  let!(:visitor_refused){ create(:user) }
  let!(:visitor_canceled){ create(:user) }
  let!(:visitor_confirmed){ create(:user) }
  let!(:not_visitor) { create(:user) }

  let(:event) { create(:event) }

  it 'gets all pending visitors' do
    create(:visit_request, :pending, event: event, user: visitor_pending)
    expect(
      described_class.call(event_id: event.id, status: ::VisitRequest::PENDING)
    ).to eq [visitor_pending]
  end

  it 'gets all approved visitors' do
    create(:visit_request, :approved, event: event, user: visitor_approved)
    expect(
      described_class.call(event_id: event.id, status: ::VisitRequest::APPROVED)
    ).to eq [visitor_approved]
  end

  it 'gets all refused visitors' do
    create(:visit_request, :refused, event: event, user: visitor_refused)
    expect(
      described_class.call(event_id: event.id, status: ::VisitRequest::REFUSED)
    ).to eq [visitor_refused]
  end

  it 'gets all canceled visitors' do
    create(:visit_request, :canceled, event: event, user: visitor_canceled)
    expect(
      described_class.call(event_id: event.id, status: ::VisitRequest::CANCELED)
    ).to eq [visitor_canceled]
  end

  it 'gets all confirmed visitors' do
    create(:visit_request, :confirmed, event: event, user: visitor_confirmed)
    expect(
      described_class.call(event_id: event.id, status: ::VisitRequest::CONFIRMED)
    ).to eq [visitor_confirmed]
  end
end
