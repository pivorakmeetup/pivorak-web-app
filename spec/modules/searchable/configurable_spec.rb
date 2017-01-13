RSpec.describe ::Searchable::Configurable do
  let(:subject) { Class.new }
  let(:definition) { Proc.new {} }

  describe '.included' do
    it 'extends target class' do
      expect(subject).to receive(:extend).with(described_class::ClassMethods)
      subject.include(described_class)
    end
  end

  before do
    subject.include(described_class)
  end

  it 'makes .define_searchable available' do
    expect(subject).to respond_to :define_searchable
  end

  it 'makes .definitions available' do
    expect(subject).to respond_to :definitions
  end

  describe '.definitions' do
    it 'returns an array' do
      expect(subject.definitions).to be_an_instance_of Array
    end
  end

  describe '.define_searchable' do
    before { subject.define_searchable(&definition) }

    it 'adds a definition to an array' do
      expect(subject.definitions).to eq [definition]
    end
  end
end
