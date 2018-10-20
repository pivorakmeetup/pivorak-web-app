require 'rails_helper'

describe VisitRequestMailer do
  before do
    Rake::Task['email_templates:seed'].execute
  end

  let(:user) { create(:user, first_name: 'Denys', last_name: 'Cool') }
  let(:event) { create(:event) }
  let(:visit_request) { create(:visit_request, user: user, event: event) }

  describe '#needs_confirmation' do
    let(:mail) { described_class.needs_confirmation(visit_request) }
    let(:email_template) { EmailTemplate.find_by!(title: 'VisitRequestMailer#needs_confirmation') }

    it 'renders the headers' do
      expect(mail.subject).to eq(email_template.subject)
      expect(mail.to).to eq([visit_request.user.email])
      expect(mail.from).to eq([ApplicationMailer::PIVORAK_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include event.title
      expect(mail.body.encoded).to include user.full_name
    end
  end

  describe '#notify_admin_about_unverified_attendee' do
    let(:mail) { described_class.notify_admin_about_unverified_attendee(visit_request) }
    let(:email_template) { EmailTemplate.find_by!(title: 'VisitRequestMailer#notify_admin_about_unverified_attendee') }

    it 'renders the headers' do
      expect(mail.subject).to eq(email_template.subject)
      expect(mail.to).to eq([ApplicationMailer::PIVORAK_EMAIL])
      expect(mail.from).to eq([ApplicationMailer::NO_REPLY_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include event.title
      expect(mail.body.encoded).to include user.full_name
    end
  end

  describe '#confirmation' do
    let(:mail) { described_class.confirmation(visit_request) }
    let(:event) { create(:event, venue: create(:venue)) }

    it 'renders the headers' do
      expect(mail.subject).to eq("Final #pivorak details! | #{event.title}")
      expect(mail.to).to eq([visit_request.user.email])
      expect(mail.from).to eq([ApplicationMailer::PIVORAK_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include event.title
      expect(mail.body.encoded).to include user.full_name
    end

    it 'renders the event attachment' do
      expect(mail.attachments['event.ics']).to be_present
      expect(mail.attachments['event.ics'].body.encoded).to include('BEGIN:VCALENDAR')
    end
  end

  describe '#attendance_confirmed' do
    let(:mail) { described_class.attendance_confirmed(visit_request.reload) }
    let(:event) { create(:event, venue: venue) }
    let(:venue) { create(:venue) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Attendance Confirmation - QR code is attached')
      expect(mail.to).to eq([visit_request.user.email])
      expect(mail.from).to eq([ApplicationMailer::PIVORAK_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include event.title
      expect(mail.body.encoded).to include user.full_name
    end

    it 'renders the pdf attachment' do
      expect(mail.attachments["#{event.slug}.pdf"]).to be_present
    end
  end

  describe '#approved' do
    let(:mail) { described_class.approved(visit_request) }
    let(:email_template) { EmailTemplate.find_by!(title: 'VisitRequestMailer#approved') }

    it 'renders the headers' do
      expect(mail.subject).to eq(email_template.subject)
      expect(mail.to).to eq([visit_request.user.email])
      expect(mail.from).to eq([ApplicationMailer::PIVORAK_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include event.title
      expect(mail.body.encoded).to include user.full_name
    end
  end

  describe '#notify_admin_about_canceled_attendee' do
    let(:mail) { described_class.notify_admin_about_canceled_attendee(visit_request) }
    let!(:email_template) do
      EmailTemplate.create!(
        title: 'VisitRequestMailer#notify_admin_about_canceled_attendee',
        subject: 'Attendee canceled his request',
        note: 'Will be sent when attendee cancels his request',
        body: File.read('db/seed/email_templates/notify_admin_about_canceled_attendee.md')
      )
    end

    it 'renders the headers' do
      expect(mail.subject).to eq(email_template.subject)
      expect(mail.to).to eq([ApplicationMailer::PIVORAK_EMAIL])
      expect(mail.from).to eq([ApplicationMailer::NO_REPLY_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include event.title
      expect(mail.body.encoded).to include user.full_name
      expect(mail.body.encoded).to have_link('here', href: "http://localhost/admin/events/#{event.slug}/visit_requests")
    end
  end
end
