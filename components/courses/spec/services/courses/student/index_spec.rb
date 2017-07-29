require 'rails_helper'

describe Courses::Student::Index do
  let!(:season) { create(:season, status: :live) }

  describe '#call' do
    it 'calls finder' do
      expect(Courses::Student::LiveSeason).to receive(:call).with(season)

      described_class.call(season)
    end
  end
end
