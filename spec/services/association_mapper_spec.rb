# frozen_string_literal: true

describe AssociationMapper do
  let(:params) { { visit_requests: %i[approved used final], visitors: %i[newbie verified] } }

  subject { described_class.call(params) }

  describe '.call' do
    it 'map all associations' do
      expect(subject).to have(5).items
    end

    it 'map associations by first key' do
      expect(subject).to include(:approved_visit_requests)
    end

    it 'map associations by second key' do
      expect(subject).to include(:newbie_visitors)
    end
  end
end
