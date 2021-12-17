# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::Create do
  subject { described_class.new(user, event) }

  let(:user) { create(:user, :tester) }
  let(:event) { create(:event) }

  shared_context 'when there are free slots' do
    let(:slots_policy) { instance_double(Event::SlotsPolicy) }

    before do
      allow(Event::SlotsPolicy).to receive(:new).and_return(slots_policy)
      allow(slots_policy).to receive(:free_slot_for?).with(user).and_return(true)
    end
  end

  shared_context 'when there are no free slots' do
    let(:slots_policy) { instance_double(Event::SlotsPolicy) }

    before do
      allow(Event::SlotsPolicy).to receive(:new).and_return(slots_policy)
      allow(slots_policy).to receive(:free_slot_for?).with(user).and_return(false)
    end
  end

  describe '#call' do
    context 'user is verified' do
      before { allow(user).to receive(:verified?).and_return(true) }

      context 'event has free slots for verified users' do
        include_context 'when there are free slots'

        before do
          allow(VisitRequest::Approve).to receive(:call).and_call_original
          subject.call
        end

        it { expect(VisitRequest::Approve).to have_received(:call) }
        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_approved }
        it { expect(event.visit_requests.last).not_to be_waiting_list }
      end

      context 'event has no free slots for verified users' do
        include_context 'when there are no free slots'

        let(:visit_request_mailer) { instance_spy(VisitRequestMailer) }

        before do
          subject.call
        end

        it { expect(visit_request_mailer).not_to have_received(:needs_confirmation) }
        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end

    context 'user is not verified' do
      before { allow(user).to receive(:verified?).and_return(false) }

      context 'event has free slots for newbies' do
        include_context 'when there are free slots'

        before do
          allow(VisitRequestMailer).to receive(:needs_confirmation).and_call_original

          subject.call
        end

        it { expect(VisitRequestMailer).to have_received(:needs_confirmation).with(event.visit_requests.last) }
        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).not_to be_waiting_list }
      end

      context 'event has no free slots for newbies' do
        include_context 'when there are no free slots'

        before do
          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end
  end
end
