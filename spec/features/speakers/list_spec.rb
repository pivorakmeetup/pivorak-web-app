# frozen_string_literal: true

RSpec.describe 'Events LIST' do
  let(:speaker) { create(:user) }
  let!(:talk) { create(:talk, speaker: speaker) }

  before do
    visit '/speakers'
  end

  it { expect(page).to have_content speaker.full_name }
end
