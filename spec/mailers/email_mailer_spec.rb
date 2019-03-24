# frozen_string_literal: true

require 'rails_helper'

describe EmailMailer do
  let(:user) { create(:user) }
  let(:email) { create(:email) }
  let(:user_id) { user.id }
  let(:email_id) { email.id }

  describe 'custom' do
    let(:mail) { EmailMailer.custom(email_id, user_id) }

    it 'renders the headers' do
      expect(mail.subject).to eq(email.subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ApplicationMailer::PIVORAK_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to eq "<p>#{email.body}</p>\r\n"
    end
  end
end
