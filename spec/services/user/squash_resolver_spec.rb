# frozen_string_literal: true

require 'rails_helper'

describe ::User::SquashResolver do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }

  let(:relations_params) do
    {
      resource:         VisitRequest,
      association_type: :has_many,
      foreign_key:      :user_id,
      source_id:        user_a.id,
      destination_id:   user_b.id
    }
  end

  let(:squash_params) do
    relations_params.merge(squash: true, conditions: %i[event_id])
  end

  describe '.call' do
    let!(:event_a) { FactoryBot.create(:event) }
    let!(:event_b) { FactoryBot.create(:event) }
    let!(:event_c) { FactoryBot.create(:event) }

    let!(:request_a)           { FactoryBot.create(:visit_request, user: user_a, event: event_a) }
    let!(:duplicate_request_a) { FactoryBot.create(:visit_request, user: user_b, event: event_a) }
    let!(:request_b)           { FactoryBot.create(:visit_request, user: user_b, event: event_b) }
    let!(:request_c)           { FactoryBot.create(:visit_request, user: user_a, event: event_c) }

    context 'when has_many associations' do
      context 'without squash' do
        context 'without duplicates' do
          let!(:talk)  { FactoryBot.create(:talk, speaker: user_a) }
          let(:params) { relations_params.merge(resource: Talk, foreign_key: :speaker_id) }

          before { described_class.call(params) }

          it { expect(user_b.talks).to     include(talk) }
          it { expect(user_a.talks).not_to include(talk) }
        end

        context 'when mixed' do
          before { described_class.call(relations_params) }

          it { expect(user_b.visit_requests).to     include(request_a, duplicate_request_a, request_b, request_c) }
          it { expect(user_a.visit_requests).not_to include(request_a) }
        end
      end

      context 'with squash' do
        before { described_class.call(squash_params) }

        it { expect(user_b.visit_requests).to     have(3).items }
        it { expect(user_b.visit_requests).to     include(duplicate_request_a, request_b, request_c) }
        it { expect(user_b.visit_requests).not_to include(request_a) }
      end
    end
  end

  describe '#schema' do
    context 'when invalid' do
      context 'with resource' do
        let(:params) { relations_params.merge(resource: 5) }

        it { expect(described_class.call(params)).to be_nil }
      end

      context 'with association type' do
        let(:params) { relations_params.merge(association_type: :belongs_to) }

        it { expect(described_class.call(params)).to be_nil }
      end

      context 'with foreign key' do
        let(:params) { relations_params.merge(foreign_key: nil) }

        it { expect(described_class.call(params)).to be_nil }
      end

      context 'with source id' do
        let(:params) { relations_params.merge(source_id: Faker::Name.name) }

        it { expect(described_class.call(params)).to be_nil }
      end

      context 'with destination id' do
        let(:params) { relations_params.merge(destination_id: nil) }

        it { expect(described_class.call(params)).to be_nil }
      end
    end

    context 'when valid' do
      it { expect(described_class.call(relations_params)).not_to be_nil }
    end
  end
end
