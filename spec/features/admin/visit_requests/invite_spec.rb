# frozen_string_literal: true

RSpec.describe 'Visit Request INVITE' do
  subject { page }

  let(:event) { create(:event) }
  let(:visit_page) { -> { visit "/admin/events/#{event.slug}/visit_requests/invite/new" } }

  let(:click_user_invite) do
    assume_admin_logged_in(supervisor: true)
    visit_page.call
    fill_in :emails, with: entered_email_data
    click_button 'Invite'
  end

  context 'when one email is entered' do
    let(:entered_email_data) { 'john.joe@email.com' }

    context 'when user with given email exists' do
      it 'creates visit request for user' do
        user = create(:user, email: entered_email_data)

        click_user_invite

        expect(VisitRequest.exists?(user_id: user.id, event_id: event.id)).to be_truthy
      end

      it 'sends email to user' do
        create(:user, email: entered_email_data)

        click_user_invite

        expect(active_jobs.size).to eq(1)
        active_job = active_jobs[0]
        expect(active_job[:job]).to eq ActionMailer::DeliveryJob
        expect(active_job[:args][0]).to eq 'VisitRequestMailer'
        expect(active_job[:args][1]).to eq 'attendance_confirmed'
      end
    end

    context 'when user with given email does not exist' do
      it 'creates user with visit request for user' do
        click_user_invite

        user = User.find_by!(email: entered_email_data)
        expect(VisitRequest.exists?(user_id: user.id, event_id: event.id)).to be_truthy
      end
    end

    context 'when email is custom' do
      let(:entered_email_data) { 'john@email.com' }

      it 'creates user with visit request for user' do
        click_user_invite

        user = User.find_by!(email: entered_email_data)
        expect(VisitRequest.exists?(user_id: user.id, event_id: event.id)).to be_truthy
      end
    end
  end

  context 'when list of email are entered' do
    let(:entered_email_data) { 'john.joe@gmail.com,  ivan@gmail.com,  , ' }

    it 'creates visit requests for given email with approved status' do
      click_user_invite

      users = User.where(email: ['john.joe@gmail.com', 'ivan@gmail.com'])

      expect(users.count).to eq(2)
      expect(VisitRequest.where(user_id: users.ids, event_id: event.id).count).to eq(2)
    end

    it 'sends emails to each user' do
      click_user_invite

      expect(active_jobs.size).to eq(2)

      active_jobs.each do |job|
        expect(job[:job]).to eq ActionMailer::DeliveryJob
        expect(job[:args][0]).to eq 'VisitRequestMailer'
        expect(job[:args][1]).to eq 'attendance_confirmed'
      end
    end
  end

  context 'when invalid email is entered' do
    let(:entered_email_data) { 'johnemail.com' }

    it 'does nothing with users and emails' do
      click_user_invite

      expect(User.where(email: entered_email_data)).to be_empty
      expect(active_jobs).to be_empty
    end
  end

  context 'when bad list of email are entered' do
    let(:entered_email_data) { 'johne.com, pe@.a.a.a' }

    it 'does nothing with users and emails' do
      click_user_invite

      expect(User.where(email: entered_email_data)).to be_empty
      expect(active_jobs).to be_empty
    end
  end
end
