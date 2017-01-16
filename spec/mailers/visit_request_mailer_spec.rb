require 'rails_helper'

describe VisitRequestMailer do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:visit_request) { create(:visit_request, user: user, event: event) }

  describe "#new_newbie_attendee" do

    let(:mail) { described_class.unverified_attendee(visit_request.id) }

    it "renders the headers" do
      expect(mail.subject).to eq('New newbie signed up to event')
      expect(mail.to).to eq([ApplicationMailer::PIVORAK_EMAIL])
      expect(mail.from).to eq([ApplicationMailer::NO_REPLY_EMAIL])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include event.title
      expect(mail.body.encoded).to include user.full_name
    end
  end
end
