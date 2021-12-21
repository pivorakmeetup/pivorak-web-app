# frozen_string_literal: true

RSpec.describe Search::Resource do
  describe '.call' do
    let(:string) { 'example' }
    let!(:user)  { create(:user, first_name: string) }

    context 'when there are matches' do
      let(:result) { described_class.call(query: string, model: user.class) }

      it 'returns resource specific collection', :aggregate_failures do
        expect(result).to be_a ActiveRecord::Relation
        expect(result.first).to be_a User
      end

      it 'returns correct amount of results' do
        expect(result.length).to eq 1
      end
    end

    context 'when there are no matches' do
      let(:result) { described_class.call(query: string.reverse, model: user.class) }

      it 'returns no results' do
        expect(result.length).to eq 0
      end
    end
  end
end
