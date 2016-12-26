require 'rails_helper'

describe VisitRequest::Attend do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  subject do
    described_class.new(user, event)
  end

  describe '#call' do
    context 'when user is fresh' do
      it { expect{ subject.call }.to change(VisitRequest, :count).by(1) }

      it 'sets pending status' do
        subject.call

        expect(VisitRequest.last.status).to eq(VisitRequest::PENDING.to_s)
      end
    end

    context 'when user has already submitted request' do
      before do
        create(:visit_request, event: event, user: user)
      end

      it { expect{ subject.call }.to change(VisitRequest, :count).by(0) }

      it 'sets pending status' do
        subject.call

        expect(VisitRequest.last.status).to eq(VisitRequest::PENDING.to_s)
      end
    end
  end
end
