RSpec.describe Searchable::Resolver do
  let(:target)     { User }
  let(:subject)    { described_class.new(target: target) }
  let(:config)     { double() }
  let(:definition) { Proc.new { pg_search_scope :by_name, against: [:first_name] } }

  before do
    allow(subject).to receive(:configuration) { config }
    allow(config).to receive(:definitions) { [definition] }
    target.include(PgSearch)
  end

  describe '#perform' do
    it 'applies search definitions to the target' do
      subject.perform
      expect(target).to respond_to :by_name
    end
  end
end
