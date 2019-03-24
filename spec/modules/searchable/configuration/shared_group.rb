# frozen_string_literal: true

RSpec.shared_examples 'Configurable' do |_action_hook|
  let(:configurable_module) { Searchable::Configurable }

  it 'responds to configurable methods' do
    expect(described_class).to respond_to :definitions
    expect(described_class).to respond_to :define_searchable
  end
end
