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

    it 'returns object and status' do
      expect(call).to eq([visit_request, :success])
    end

    context 'when already checked in' do
      let(:visit_request) { create(:visit_request, :approved, :visited) }

      it 'returns object and status' do
        expect(call).to eq([visit_request, :already_visited])
      end
    end

    context 'when rejected' do
      let(:visit_request) { create(:visit_request, :refused) }

      it 'returns object and status' do
        expect(call).to eq([visit_request, :invalid_status])
      end
    end

    context 'when visit request not passed' do
      let(:visit_request) { nil }

      it 'returns object and status' do
        expect(call).to eq([visit_request, :not_found])
      end
    end
  end
end
