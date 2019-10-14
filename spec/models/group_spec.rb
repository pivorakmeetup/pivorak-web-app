# frozen_string_literal: true

require 'dry_helpers/model'

RSpec.describe Group do
  describe 'relations' do
    Group::RESOURCES.each do |resource|
      it { is_expected.to have_many(resource_to_many(resource)) }
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:resource) }
  end
end
