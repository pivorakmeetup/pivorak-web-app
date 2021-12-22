# frozen_string_literal: true

RSpec.describe 'Events LIST' do
  let(:speaker) { create(:user) }

  before do
    create(:talk, speaker: speaker)

    visit '/speakers'
  end

  it { expect(page).to have_content speaker.full_name }
end
