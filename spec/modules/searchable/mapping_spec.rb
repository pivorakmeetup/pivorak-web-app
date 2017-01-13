RSpec.describe ::Searchable::Mapping do
  it 'contains configuration mapping' do
    expect(described_class::MAPPING).not_to be nil
  end
end

