RSpec.describe 'Emails PREVIEW' do
  context 'when user is admin' do
    before do
      assume_admin_logged_in
      Rake::Task['email_templates:seed'].execute
    end

    describe 'UserMailer#confirmation_instructions' do
      it do
        create(:user)
        visit '/emails/en/user_mailer_preview-confirmation_instructions'
        expect(page.status_code).to eq(200)
      end
    end

    describe 'UserMailer#reset_password_instructions' do
      it do
        create(:user)
        visit '/emails/en/user_mailer_preview-reset_password_instructions'
        expect(page.status_code).to eq(200)
      end
    end

    describe 'VisitRequestMailer#approved' do
      it do
        create(:visit_request)
        visit '/emails/en/visit_request_mailer_preview-approved'
        expect(page.status_code).to eq(200)
      end
    end

    describe 'VisitRequestMailer#confirmation' do
      it do
        event = create(:event, venue: create(:venue))
        create(:visit_request, event: event)
        visit '/emails/en/visit_request_mailer_preview-confirmation'
        expect(page.status_code).to eq(200)
      end
    end

    describe 'VisitRequestMailer#needs_confirmation' do
      it do
        create(:visit_request)
        visit '/emails/en/visit_request_mailer_preview-needs_confirmation'
        expect(page.status_code).to eq(200)
      end
    end

    describe 'VisitRequestMailer#notify_admin_about_unverified_attendee' do
      it do
        create(:visit_request)
        visit '/emails/en/visit_request_mailer_preview-notify_admin_about_unverified_attendee'
        expect(page.status_code).to eq(200)
      end
    end

    describe 'VisitRequestMailer#notify_admin_about_canceled_attendee' do
      it do
        EmailTemplate.create!(
          title: 'VisitRequestMailer#notify_admin_about_canceled_attendee',
          subject: 'Attendee canceled his request',
          note: 'Will be sent when attendee cancels his request',
          body: File.read('db/seed/email_templates/notify_admin_about_canceled_attendee.md')
        )
        create(:visit_request)
        visit '/emails/en/visit_request_mailer_preview-notify_admin_about_canceled_attendee'
        expect(page.status_code).to eq(200)
      end
    end
  end

  context 'when user is not admin' do
    describe 'VisitRequestMailer#notify_admin_about_unverified_attendee' do
      it do
        create(:visit_request)
        expect { visit '/emails/en/visit_request_mailer_preview-notify_admin_about_unverified_attendee' }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end
