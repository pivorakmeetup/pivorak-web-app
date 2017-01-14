require 'rails_helper'

describe VisitRequest::Create do
  let(:user)  { create(:user, :tester) }
  let(:event) { create(:event) }

  subject { described_class.new(user, event) }

  describe '#call' do
    context 'user is verified' do
      before { allow(user).to receive(:verified?) { true } }

      context 'event has free slots for verified users' do
        before do
          allow(event).to receive(:has_free_slot_for?).with(user) { true }
          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_approved }
        it { expect(event.visit_requests.last).to_not be_waiting_list }
      end

      context 'event not has free slots for verified users' do
        before do
          allow(event).to receive(:has_free_slot_for?).with(user) { false }
          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end

    context 'user is not verified' do
      before { allow(user).to receive(:verified?) { false } }

      context 'event has free slots for newbies' do
        before do
          allow(event).to receive(:has_free_slot_for?).with(user) { true }

          mailer = double('mailer')
          expect(VisitRequestMailer).to receive(:unverified_attendee) { mailer }
          expect(mailer).to receive(:deliver_later)

          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to_not be_waiting_list }
      end

      context 'event not has free slots for newbies' do
        before do
          allow(event).to receive(:has_free_slot_for?).with(user) { false }
          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end
  end
end
