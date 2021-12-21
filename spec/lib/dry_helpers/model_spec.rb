# frozen_string_literal: true

require 'dry_helpers/model'

RSpec.describe 'DRYHelpers/Model', type: :system do
  describe 'resource_to_many' do
    before do
      stub_const('Tree', Class.new)
      stub_const('SuperResource', Class.new)
    end

    it 'convert class name to plutal symbol', :aggregate_failures do
      expect(resource_to_many(Tree)).to eq :trees
      expect(resource_to_many(SuperResource)).to eq :super_resources
    end
  end
end
