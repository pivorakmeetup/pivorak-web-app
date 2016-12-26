RSpec.describe 'Visit Requests ATTEND' do
  let(:event) { create(:event) }

  context 'when user is logged in' do
    before do
      assume_logged_in
      visit "/events/#{event.slug}"
    end

    it { expect(page).to have_link I18n.t('visit_requests.attend') }

    it 'click on Visit redirects to event' do
      click_link I18n.t('visit_requests.attend')
      expect(page).to have_current_path("/events/#{event.slug}")
    end

    it { expect { click_link I18n.t('visit_requests.attend') }.to change(VisitRequest, :count).by(1) }
  end

  context 'when user is not logged in' do
    before do
      visit "/events/#{event.id}"
    end

    it { expect(page).to_not have_link I18n.t('visit_requests.attend') }
    it { expect(page).to have_content I18n.t('visit_requests.unauthorized') }
  end
end
