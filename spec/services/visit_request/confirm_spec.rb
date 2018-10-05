require 'rails_helper'

describe VisitRequest::Confirm do
  let(:visit_request) { create(:visit_request) }

  subject do
    described_class.new(visit_request)
  end

  describe '#call' do
    it 'sets approved status' do
      mailer = instance_double('mail')
      expect(VisitRequestMailer).to receive(:attendance_confirmed).with(visit_request) { mailer }
      expect(mailer).to receive(:deliver_later)

      subject.call

      expect(visit_request.reload).to be_confirmed
    end
  end
end
