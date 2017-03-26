require 'rails_helper'

RSpec.describe Talk::IncreasingPerMonth do
  let!(:talk)  { create(:talk, created_at: Time.zone.now - 1.month) }
  let!(:talk2) { create(:talk, created_at: Time.zone.now) }
  let!(:talk3) { create(:talk, created_at: Time.zone.now + 1.month) }

  it 'last should eq sum of all' do
    expect(described_class.call.values.last).to eq 3
  end
end
