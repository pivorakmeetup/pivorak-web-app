# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::FinalDecision do
  let(:final_decision_service) { described_class.new(visit_request, answer: answer) }
  let(:visit_request) { create(:visit_request, status: 'pending') }

  describe '#call' do
    context 'when answer is :yes' do
      let(:answer) { 'yes' }

      it 'calls confirm service' do
        allow(VisitRequest::Confirm).to receive(:call)

        final_decision_service.call

        expect(VisitRequest::Confirm).to have_received(:call)
      end
    end

    context 'when answer is :no' do
      let(:answer) { 'no' }

      it 'calls cancel service' do
        allow(VisitRequest::Refuse).to receive(:call)

        final_decision_service.call

        expect(VisitRequest::Refuse).to have_received(:call)
      end
    end

    context 'when other answers' do
      let(:answer) { 'maybe' }

      it 'fails with an error' do
        expect { final_decision_service.call }.to raise_error(described_class::UnrecognizedAnswerError)
      end
    end
  end
end
