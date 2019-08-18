# frozen_string_literal: true

RSpec.describe 'Visit Requests ATTEND' do
  let(:event)                 { create(:event, limit_total: 2, limit_verified: 1) }
  let(:code_of_conduct_url)   { 'code-of-conduct' }
  let!(:code_of_conduct_page) { create(:page, url: code_of_conduct_url) }

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

        it { expect(page).to have_current_path("/#{code_of_conduct_url}") }
        it { expect(page).to_not have_link 'Attend' }
        xit { expect(page).to have_content I18n.t('visit_requests.messages.pending') }
        it { expect(page).to have_content I18n.t('flash.visit_requests.create.success_for_newbies') }
        xit { expect(page).to have_link 'Cancel attendance' }

        it 'enques needs confirmation' do
          active_job = active_jobs[0]
          expect(active_job[:job]).to eq ActionMailer::DeliveryJob
          expect(active_job[:args][0]).to eq 'VisitRequestMailer'
          expect(active_job[:args][1]).to eq 'needs_confirmation'
        end
      end

      context 'as verified member' do
        let(:verified_member) { create(:user, :verified) }

        before do
          assume_logged_in(verified_member)
          click_link 'Attend'
        end

        it { expect(page).to have_current_path("/#{code_of_conduct_url}") }
        it { expect(page).to_not have_link 'Attend' }
        xit { expect(page).to have_content I18n.t('visit_requests.messages.approved') }
        it { expect(page).to have_content I18n.t('flash.visit_requests.create.success_for_verified') }
        xit { expect(page).to have_link 'Cancel attendance' }
      end
    end
  end

  context 'when user is not logged in' do
    before do
      visit "/events/#{event.id}"
    end

    describe 'event page' do
      it { expect(page).to_not have_link 'Attend' }
      it { expect(page).to have_content 'Please log in or register and then enroll in this event to attend' }
    end
  end
end
