RSpec.describe 'Visit Requests CONFIRMATION' do
  let(:event)          { create(:event, status: :confirmation) }
  let(:user)           { create(:user)  }
  let!(:visit_request) { create(:visit_request, user: user, event: event, status: :approved) }

  before do
    assume_logged_in(user)
    visit "/events/#{event.slug}"
  end

  context 'User can confirm or refuse visit request' do
    it { expect(page).to have_content I18n.t('visit_requests.messages.please_confirm') }
    it { expect(page).to have_link 'Confirm' }
    it { expect(page).to have_link 'Refuse' }
  end

  context 'Click Confirm' do
    before { click_link 'Confirm' }

    it { expect(page).to have_content I18n.t('visit_requests.messages.see_you') }
    it { expect(page).to have_content I18n.t('visit_requests.messages.see_you') }
    it { expect(page).to have_content I18n.t('flash.visit_requests.show.confirmed') }
    it { expect(page).to_not have_content I18n.t('visit_requests.messages.so_pity') }
    it { expect(page).to_not have_link 'Confirm' }
    it { expect(page).to have_link 'Refuse' }
  end

  context 'Click Refuse' do
    before { click_link 'Refuse' }

    it { expect(page).to have_content I18n.t('visit_requests.messages.so_pity') }
    it { expect(page).to_not have_content I18n.t('visit_requests.messages.see_you') }
    it { expect(page).to have_content I18n.t('flash.visit_requests.show.refused') }
    it { expect(page).to_not have_link 'Confirm' }
    it { expect(page).to_not have_link 'Refuse' }
  end

  context 'Get application closed message' do
    before { logout and visit("/events/#{event.slug}") }

    it { expect(page).to have_content I18n.t('visit_requests.messages.registration_closed') }
  end
end
