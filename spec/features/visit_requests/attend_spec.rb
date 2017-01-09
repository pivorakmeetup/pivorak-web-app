RSpec.describe 'Visit Requests ATTEND' do
  let(:event) { create(:event, limit_total: 2, limit_verified: 1) }

  context 'when user is logged in' do
    before do
      assume_logged_in
      visit "/events/#{event.slug}"
    end

    describe 'event page' do
      it { expect(page).to have_link 'Attend' }
      it { expect(page).to_not have_content 'Please login or register to attend this event' }
    end

    describe 'click attend' do
      context 'as newbie' do
        before { click_link 'Attend' }

        it { expect(page).to have_current_path("/events/#{event.slug}") }
        it { expect(page).to_not have_link 'Attend' }
        it { expect(page).to have_content I18n.t('visit_requests.messages.pending') }
        it { expect(page).to have_link 'Cancel attendance' }
      end

      context 'as verified member' do
        let(:verified_member) { create(:user, :verified) }

        before do
          assume_logged_in(verified_member)
          click_link 'Attend'
        end

        it { expect(page).to have_current_path("/events/#{event.slug}") }
        it { expect(page).to_not have_link 'Attend' }
        it { expect(page).to have_content I18n.t('visit_requests.messages.approved') }
        it { expect(page).to have_link 'Cancel attendance' }
      end
    end
  end

  context 'when user is not logged in' do
    before do
      visit "/events/#{event.id}"
    end

    describe 'event page' do
      it { expect(page).to_not have_link 'Attend' }
      it { expect(page).to have_content 'Please login or register to attend this event' }
    end
  end
end
