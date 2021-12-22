# frozen_string_literal: true

RSpec.describe ::Searchable do
  let(:searchable_subject) { Class.new }
  let(:resolver)      { ::Searchable::Resolver }
  let(:search_module) { PgSearch }

  describe '.included' do
    it 'calls resolver with correct arguments' do
      allow(resolver).to receive(:call).with(target: searchable_subject)

      searchable_subject.include(described_class)

      expect(resolver).to have_received(:call).with(target: searchable_subject)
    end

    it 'responds to search module methods', :aggregate_failures do
      allow(resolver).to receive(:call).and_return(true)
      searchable_subject.include(described_class)

      expect(searchable_subject).to respond_to :pg_search_scope
      expect(searchable_subject).to respond_to :multisearchable
    end
  end

  describe '.search_module' do
    it 'returns correct class' do
      expect(described_class.search_module).to eq search_module
    end
  end

  describe '.resolver' do
    it 'returns correct class' do
      expect(described_class.resolver).to eq resolver
    end
  end
end
