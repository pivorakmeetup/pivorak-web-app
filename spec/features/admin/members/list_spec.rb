# frozen_string_literal: true

RSpec.describe 'Members LIST' do
  let!(:user) { create(:user) }

  before do
    assume_admin_logged_in(supervisor: true)
  end

  it 'has member name' do
    visit '/admin'
    click_link('Members', match: :first)
    expect(page).to have_content user.full_name
  end

  describe 'filtering' do
    context 'when synthetic filter is turned on`' do
      let!(:synthetic_user) { create(:user, :synth) }
      let!(:non_synthetic_user) { create(:user, first_name: 'Denys') }

      it 'filters on synthetic users' do
        visit '/admin/members?filter_member[synthetic]=1'

        expect(page).to have_content synthetic_user.full_name
        expect(page).not_to have_content non_synthetic_user.full_name
      end
    end

    context 'when verified filter is turned on`' do
      let!(:verified_user) { create(:user, :verified) }
      let!(:non_verified_user) { create(:user, first_name: 'Denys', verified: false) }

      it 'filters on verified users' do
        visit '/admin/members?filter_member[verified]=1'

        expect(page).to have_content verified_user.full_name
        expect(page).not_to have_content non_verified_user.full_name
      end
    end

    context 'when verified and synthetic is turned on' do
      let!(:synthetic_user) { create(:user, :synth, :verified) }
      let!(:non_synthetic_user) { create(:user, verified: false) }

      it 'filters on synthetic and verified users' do
        visit '/admin/members?filter_member[synthetic]=1'

        expect(page).to have_content synthetic_user.full_name
        expect(page).not_to have_content non_synthetic_user.full_name
      end
    end

    context 'when speakers filter is turned on`' do
      let!(:speaker) do
        speaker_user = create(:user)
        create(:talk, speaker: speaker_user)
        speaker_user
      end
      let!(:non_speaker) { create(:user) }

      it 'filters on speakers users' do
        visit '/admin/members?filter_member[speaker]=1'

        expect(page).to have_content speaker.full_name
        expect(page).not_to have_content non_speaker.full_name
      end
    end

    context 'when reset filters link is clicked' do
      it 'returns to the virgin state' do
        visit '/admin/members?filter_member[speaker]=1'

        click_link('Reset filters', match: :first)

        expect(page).to have_current_path('/admin/members')
      end
    end
  end
end
