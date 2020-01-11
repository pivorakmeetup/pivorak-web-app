# frozen_string_literal: true

RSpec.describe 'Coming Soon page' do
  subject { page }

  context 'when there are no events' do
    it 'renders coming soon page with unknown date' do
      visit root_path

      expect(page).to have_content(I18n.t('coming_soon.next_event', upcoming_date: 'soon'))
      expect(page).to have_content(I18n.t('coming_soon.cfp_is_open'))
    end
  end

  context 'when there is planned event' do
    it 'renders coming soon page with event date' do
      travel_to(Time.zone.parse('2018-01-11 12:00')) do
        create(:event, status: :passed, started_at: 2.months.ago)
        create(:event, published: false, started_at: 2.months.from_now)
        # planned event
        create(:event, published: false, status: :planned, started_at: 1.month.from_now)

        visit root_path

        expect(page).to have_content(I18n.t('coming_soon.next_event', upcoming_date: '11th of February'))
        expect(page).to have_content(I18n.t('coming_soon.cfp_is_open'))
      end
    end
  end

  context 'when there is published event' do
    before { create(:event, started_at: 1.month.from_now) }

    it 'renders event page' do
      visit root_path

      expect(page).not_to have_content(I18n.t('coming_soon.cfp_is_open'))
      expect(page).not_to have_content(I18n.t('coming_soon.next_event', upcoming_date: 'soon'))
    end
  end
end
