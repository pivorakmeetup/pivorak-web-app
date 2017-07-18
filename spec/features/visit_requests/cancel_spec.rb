RSpec.describe 'Visit Requests CANCEL' do
  let(:event)          { create(:event) }
  let(:user)           { create(:user)  }
  let!(:visit_request) { create(:visit_request, user: user, event: event) }

  context 'when user is not logged in' do
    before do
      visit "/events/#{event.id}"
    end

    describe 'event page' do
      it { expect(page).to_not have_link 'Attend' }
      it { expect(page).to have_content 'Please log in or register and then enroll in this event to attend' }
    end
  end

  context 'when user is logged in' do
    before do
      assume_logged_in(user)
      visit "/events/#{event.slug}"
    end

    describe "click 'Cancel attendance'" do
      before { click_link 'Cancel attendance' }

      it { expect(page).to have_current_path("/") }
      it { expect(page).to_not have_link 'Attend' }

      it 'changes visit request status to canceled' do
        expect(visit_request.reload.status).to eq(VisitRequest::CANCELED.to_s)
      end

      it 'shows flash message' do
        expect(page).to have_content I18n.t('flash.visit_requests.destroy.success')
      end

      it 'sends email to admin' do
        active_job = active_jobs[0]
        expect(active_job[:job]).to eq ActionMailer::DeliveryJob
        expect(active_job[:args][0]).to eq 'VisitRequestMailer'
        expect(active_job[:args][1]).to eq 'notify_admin_about_canceled_attendee'
      end
    end
  end
end