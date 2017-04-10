require 'rails_helper'

RSpec.describe Profiling::User::Speakers do
  let!(:user)  { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:talk)  { create(:talk, speaker: user) }
  let!(:talk2) { create(:talk, speaker: user2) }
  let!(:talk3) { create(:talk, speaker: user2) }

  it 'count only users with some talks' do
    expect(described_class.call.count).to eq 2
  end
end
