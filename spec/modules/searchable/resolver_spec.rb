# frozen_string_literal: true

RSpec.describe Searchable::Resolver do
  subject(:resolver) { described_class.new(target: target) }

  let(:target)     { User }
  let(:config)     { double }
  let(:definition) { proc { pg_search_scope :by_name, against: [:first_name] } }

  before do
    resolver.instance_variable_set(:@configuration, config)
    allow(config).to receive(:definitions) { [definition] }
    target.include(PgSearch)
  end

  describe '#perform' do
    it 'applies search definitions to the target' do
      resolver.call

      expect(target).to respond_to :by_name
    end
  end
end
