require 'rails_helper'

describe VisitRequestMailer do
  before do
    require 'rake'
    Rails.application.load_tasks
    Rake::Task['email_templates:seed'].execute
  end

  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:visit_request) { create(:visit_request, user: user, event: event) }

  describe '#unverified_attendee' do
    let(:mail) { described_class.unverified_attendee(visit_request.id) }
    let(:email_template) { EmailTemplate.find_by!(title: 'VisitRequestMailer#unverified_attendee') }

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
    let(:email_template) { EmailTemplate.find_by!(title: 'VisitRequestMailer#confirmation') }

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
end
