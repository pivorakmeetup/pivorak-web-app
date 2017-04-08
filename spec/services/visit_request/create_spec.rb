require 'rails_helper'

describe VisitRequest::Create do
  let(:event) { create(:event) }

  subject { described_class.new(user.id, event) }

  describe '#call' do
    context 'user is verified' do
      let(:user)  { create(:user, :tester, :verified) }

      context 'event has free slots for verified users' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:has_free_slot_for?).with(user.id) { true }
          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_approved }
        it { expect(event.visit_requests.last).to_not be_waiting_list }
      end

      context 'event has no free slots for verified users' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:has_free_slot_for?).with(user.id) { false }

          expect(VisitRequestMailer).not_to receive(:unverified_attendee)

          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end

    context 'user is not verified' do
      let(:user)  { create(:user, :tester, verified: false) }

      context 'event has free slots for newbies' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:has_free_slot_for?).with(user.id) { true }

          mailer = double('mailer')
          expect(VisitRequestMailer).to receive(:unverified_attendee) { mailer }
          expect(mailer).to receive(:deliver_later)

          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to_not be_waiting_list }
      end

      context 'event has no free slots for newbies' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:has_free_slot_for?).with(user.id) { false }
          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end
  end
end
