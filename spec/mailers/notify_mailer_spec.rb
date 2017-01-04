require 'rails_helper'

describe NotifyMailer do
  let(:name) { Faker::Name.name }
  let(:mail_from) { Faker::Internet.email }
  let(:mail_text) { Faker::Lorem.paragraph }
  let(:mail_to) { ApplicationMailer::PIVORAK_EMAIL }


  describe "become_speaker" do

    let(:mail_subject) { "I want to be a speaker" }

    let(:mail) { NotifyMailer.become_speaker({
      name: name,
      email: mail_from,
      text: mail_text
    }) }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([mail_to])
      expect(mail.from).to eq([mail_from])
    end

    it "renders the body" do
      expect(mail.body.encoded).to eq mail_text
    end
  end
end
