require 'rails_helper'

describe VisitRequestMailer do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:visit_request) { create(:visit_request, user: user, event: event) }

  describe '#unverified_attendee' do
    let!(:email_template) { create(:email_template, name: "#{described_class}#unverified_attendee", body: File.read('app/views/mailers/visit_request_mailer/unverified_attendee.slim')) }
    let(:mail) { described_class.unverified_attendee(visit_request.id) }

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
    let!(:email_template) { create(:email_template, name: "#{described_class}#confirmation", body: File.read('app/views/mailers/visit_request_mailer/confirmation.slim')) }
    let(:mail) { described_class.confirmation(visit_request) }

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

  describe '#approved' do
    let!(:email_template) { create(:email_template, name: "#{described_class}#approved", body: File.read('app/views/mailers/visit_request_mailer/approved.slim')) }
    let(:mail) { described_class.approved(visit_request) }

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
end
