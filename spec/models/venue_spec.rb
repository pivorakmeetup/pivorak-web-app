# frozen_string_literal: true

RSpec.describe Venue, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:map_url) }
  end
end
