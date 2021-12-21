# frozen_string_literal: true

RSpec.describe ::Searchable::Configurable do
  let(:configurable_subject) { Class.new }
  let(:definition) { proc {} }

  before do
    configurable_subject.include(described_class)
  end

  describe '.included' do
    it 'extends target class' do
      expect(configurable_subject).to receive(:extend).with(described_class::ClassMethods)
      configurable_subject.include(described_class)
    end
  end

  it 'makes .define_searchable available' do
    expect(configurable_subject).to respond_to :define_searchable
  end

  it 'makes .definitions available' do
    expect(configurable_subject).to respond_to :definitions
  end

  describe '.definitions' do
    it 'returns an array' do
      expect(configurable_subject.definitions).to be_an_instance_of Array
    end
  end

  describe '.define_searchable' do
    before { configurable_subject.define_searchable(&definition) }

    it 'adds a definition to an array' do
      expect(configurable_subject.definitions).to eq [definition]
    end
  end
end
