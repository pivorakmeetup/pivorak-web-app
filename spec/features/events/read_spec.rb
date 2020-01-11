# frozen_string_literal: true

RSpec.describe 'Events READ' do
  let(:event) { create(:event) }
  let(:user)  { create(:user, first_name: 'Attendee') }

  describe 'attendees' do
    let(:not_attendee) { create(:user, first_name: 'Not Attendee') }
    let(:other_event_attendee) { create(:user, first_name: 'Other Event Attendee') }

    before do
      event
      create(:visit_request, :final, event: event, user: user)
      create(:visit_request, :final, event: create(:event), user: other_event_attendee)
      create(:visit_request, event: event, user: not_attendee)
      visit "/events/#{event.slug}"
    end

    it { expect(page).not_to have_content not_attendee.full_name }
    it { expect(page).not_to have_content other_event_attendee.full_name }
  end
end
