RSpec.describe 'Coming Soon page' do
  subject { page }

  context 'when all events are passed' do
    before { create(:event, status: Event::PASSED, started_at: 1.month.ago) }


    it 'renders coming soon page' do
      visit root_path

      expect(page).to have_content(I18n.t('coming_soon.cfp_is_open'))
    end
  end

  context 'when there is published event' do
    before { create(:event, started_at: 1.month.from_now) }

    it 'renders event page' do
      visit root_path

      expect(page).not_to have_content(I18n.t('coming_soon.cfp_is_open'))
    end
  end
end
