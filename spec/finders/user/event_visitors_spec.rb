# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::EventVisitors do
  let!(:visitor) { create(:user) }
  let!(:not_visitor) { create(:user) }
  let!(:event) { create(:event) }

  it 'includes corrrect records' do
    create(:visit_request, event: event, user: visitor, visited: true)
    create(:visit_request, event: event, user: not_visitor)

    expect(described_class.call(event_id: event.id)).to eq [visitor]
  end
end
