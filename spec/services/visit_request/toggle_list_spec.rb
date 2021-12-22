# frozen_string_literal: true

require 'rails_helper'

describe VisitRequest::ToggleList do
  subject(:call) { described_class.call(visit_request) }

  context 'when request is in waiting list' do
    let(:visit_request) { create(:visit_request, waiting_list: true) }

    it 'changes list to main' do
      expect { call }.to change(visit_request.reload, :waiting_list).from(true).to(false)
    end

    it 'enques needs confirmation', :aggregate_failures do
      call

      active_job = active_jobs[0]
      expect(active_job[:job]).to eq ActionMailer::DeliveryJob
      expect(active_job[:args][0]).to eq 'VisitRequestMailer'
      expect(active_job[:args][1]).to eq 'confirmation'
    end
  end

  context 'when request is in main list' do
    let(:visit_request) { create(:visit_request, waiting_list: false) }

    it 'changes list to waiting' do
      expect { call }.to change(visit_request.reload, :waiting_list).from(false).to(true)
    end
  end
end
