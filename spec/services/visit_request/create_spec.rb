# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::Create do
  subject { described_class.new(user, event) }

  let(:user)  { create(:user, :tester) }
  let(:event) { create(:event) }

  describe '#call' do
    context 'user is verified' do
      before { allow(user).to receive(:verified?).and_return(true) }

      context 'event has free slots for verified users' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:free_slot_for?).with(user).and_return(true)

          expect(VisitRequest::Approve).to receive(:call).and_call_original

          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_approved }
        it { expect(event.visit_requests.last).not_to be_waiting_list }
      end

      context 'event has no free slots for verified users' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:free_slot_for?).with(user).and_return(false)

          expect(VisitRequestMailer).not_to receive(:needs_confirmation) { mailer }

          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end

    context 'user is not verified' do
      before { allow(user).to receive(:verified?).and_return(false) }

      context 'event has free slots for newbies' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:free_slot_for?).with(user).and_return(true)

          expect(VisitRequestMailer).to receive(:needs_confirmation).and_call_original

          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).not_to be_waiting_list }
      end

      context 'event has no free slots for newbies' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:free_slot_for?).with(user).and_return(false)
          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end
  end
end
