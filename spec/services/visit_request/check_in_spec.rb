require 'rails_helper'

RSpec.describe VisitRequest::CheckIn do
  subject(:service) { described_class.new(visit_request) }

  let(:visit_request) { create(:visit_request, :approved) }

  describe '#call' do
    subject(:call) { service.call }

    it 'updates visited flag' do
      expect { call }.to change(visit_request.reload, :visited).from(false).to(true)
    end

    it 'updates checked_in_at' do
      Timecop.freeze Time.zone.now do
        expect { call }.to change(visit_request.reload, :checked_in_at).from(nil).to(Time.zone.now)
      end
    end

    context 'when already checked in' do
      let(:visit_request) { create(:visit_request, :visited) }

      it { expect { call }.to raise_error(VisitRequest::CheckIn::AlreadyCheckedIn) }
    end

    context 'when rejected' do
      let(:visit_request) { create(:visit_request, :refused) }

      it { expect { call }.to raise_error(VisitRequest::CheckIn::InvalidStatus) }
    end
  end
end
