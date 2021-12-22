# frozen_string_literal: true

describe AssociationMapper do
  subject(:map_association) { described_class.call(params) }

  let(:params) { { visit_requests: %i[approved used final], visitors: %i[newbie verified] } }

  describe '.call' do
    it 'map all associations' do
      expect(map_association).to have(5).items
    end

    it 'map associations by first key' do
      expect(map_association).to include(:approved_visit_requests)
    end

    it 'map associations by second key' do
      expect(map_association).to include(:newbie_visitors)
    end
  end
end
