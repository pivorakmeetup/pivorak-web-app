# frozen_string_literal: true

require 'rails_helper'

describe UserMailer do
  before do
    Rake::Task['email_templates:seed'].execute
  end

  let(:user) { create(:user) }

  describe '#confirmation_instructions' do
    let(:mail) { described_class.confirmation_instructions(user, 'abcde') }
    let(:email_template) { EmailTemplate.find_by!(title: 'UserMailer#confirmation_instructions') }

    it 'renders the headers', :aggregate_failures do
      expect(mail.subject).to eq(email_template.subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ApplicationMailer::NO_REPLY_EMAIL])
    end

    it 'renders the body', :aggregate_failures do
      expect(mail.body).to include user.email
      expect(mail.body).to include 'You can confirm your account email through the link below'
    end
  end

  describe '#reset_password_instructions' do
    let(:mail) { described_class.reset_password_instructions(user, 'abcde') }
    let(:email_template) { EmailTemplate.find_by!(title: 'UserMailer#reset_password_instructions') }

    it 'renders the headers', :aggregate_failures do
      expect(mail.subject).to eq(email_template.subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ApplicationMailer::NO_REPLY_EMAIL])
    end

    it 'renders the body', :aggregate_failures do
      expect(mail.body).to include user.email
      expect(mail.body.encoded).to include 'Someone has requested a link to change your password'
    end
  end
end
