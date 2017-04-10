require 'rails_helper'
RSpec.describe User::Speakers do
  let!(:speaker) { create(:user) }
  let!(:twice_speaker) { create(:user) }
  let!(:not_speaker) { create(:user) }
  let!(:talk) { create(:talk, speaker: speaker) }
  let!(:talk2) { create(:talk, speaker: twice_speaker) }
  let!(:talk3) { create(:talk, speaker: twice_speaker) }
  it 'count only users with some talks' do
    expect(described_class.call).to_not include not_speaker
    expect(described_class.call).to include speaker
    expect(described_class.call).to include twice_speaker
  end
end
