require 'rails_helper'

describe VisitRequest::FinalConfirmation do
  let(:visit_request) { create(:visit_request, status: 'pending') }

  subject { described_class.new(visit_request, answer: answer) }

  describe '#call' do
    context 'when answer is :yes' do
      let(:answer) { 'yes' }

      it 'sets :confirmed status' do
        subject.call

        expect(visit_request.reload.status).to eq(VisitRequest::CONFIRMED.to_s)
      end
    end

    context 'when answer is :no' do
      let(:answer) { 'no' }

      it 'sets :refused status' do
        subject.call

        expect(visit_request.reload.status).to eq(VisitRequest::REFUSED.to_s)
      end
    end

    context 'for other answers' do
      let(:answer) { 'maybe' }

      it 'fails with an error' do
        expect { subject.call }.to raise_error(described_class::UnrecognizedAnswerError)
      end
    end
  end
end
