# frozen_string_literal: true

require 'dry_helpers/model'

RSpec.describe 'DRYHelpers/Model' do
  describe 'resource_to_many' do
    it 'convert class name to plutal symbol' do
      Tree          = Class.new
      SuperResource = Class.new

      expect(resource_to_many(Tree)).to eq :trees
      expect(resource_to_many(SuperResource)).to eq :super_resources
    end
  end
end
