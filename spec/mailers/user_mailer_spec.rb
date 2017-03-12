require 'rails_helper'

describe UserMailer do
  let(:user) { create(:user) }

  describe '#confirmation_instructions' do
    let!(:email_template) { create(:email_template, name: "#{described_class}#confirmation_instructions", body: File.read('app/views/users/mailer/confirmation_instructions.html.slim')) }
    let(:mail) { described_class.confirmation_instructions(user, 'abcde') }

    it 'renders the headers' do
      expect(mail.subject).to eq(email_template.subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ApplicationMailer::NO_REPLY_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body).to include user.email
      expect(mail.body).to include 'You can confirm your account email through the link below'
    end
  end

  describe '#reset_password_instructions' do
    let!(:email_template) { create(:email_template, name: "#{described_class}#reset_password_instructions", body: File.read('app/views/users/mailer/reset_password_instructions.html.slim')) }
    let(:mail) { described_class.reset_password_instructions(user, 'abcde') }

    it 'renders the headers' do
      expect(mail.subject).to eq(email_template.subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ApplicationMailer::NO_REPLY_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body).to include user.email
      expect(mail.body.encoded).to include 'Someone has requested a link to change your password'
    end
  end
end
