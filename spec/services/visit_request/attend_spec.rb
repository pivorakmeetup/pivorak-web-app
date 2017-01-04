require 'rails_helper'

describe VisitRequest::Attend do
  let(:user)  { create(:user, :tester) }
  let(:event) { create(:event) }

  subject { described_class.new(user, event) }

  describe '#call' do
    context 'user is verified and event has free slots for verified users' do
      before do
        allow(user).to  receive(:verified?) { true }
        allow(event).to receive(:has_free_verified_slots?) { true }

        subject.call
      end

      it { expect(event.visit_requests).to have(1).item }
      it { expect(event.visit_requests.last).to be_approved }
    end

    context 'user is not verified' do
      before { subject.call }

      it { expect(event.visit_requests).to have(1).item }
      it { expect(event.visit_requests.last).to be_pending }
    end
  end
end
