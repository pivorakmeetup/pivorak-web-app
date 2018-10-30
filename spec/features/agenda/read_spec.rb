RSpec.describe 'Agenda page' do
  subject { page }

  context 'when upcoming event exist' do
    it 'shows event agenda' do
      create(:event, status: :confirmation, started_at: 1.month.ago)
      event = create(:event, status: :confirmation, agenda: 'agenda text', started_at: Time.zone.now, finished_at: 1.hour.from_now)

      visit "/agenda"

      expect(page).to have_content(event.agenda)
    end
  end

  context 'when no upcoming event exist' do
    it 'returns 404' do
      create(:event, status: :confirmation, started_at: 2.days.ago, finished_at: 1.day.ago)

      visit "/agenda"

      expect(page).to have_http_status(404)
    end
  end
end
