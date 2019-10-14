# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::EventApplied do
  let!(:visitor_approved) { create(:user) }
  let!(:visitor_pending) { create(:user) }
  let!(:visitor_refused) { create(:user) }
  let!(:not_visitor) { create(:user) }

  let(:event) { create(:event) }

  it 'grabs all users from one event' do
    create(:visit_request, :approved, event: event, user: visitor_approved)
    create(:visit_request, :pending, event: event, user: visitor_pending)
    create(:visit_request, :refused, event: event, user: visitor_refused)

    expect(
      described_class.call(event_id: event.id).sort_by(&:id)
    ).to eq [visitor_approved, visitor_pending, visitor_refused].sort_by(&:id)
  end
end
