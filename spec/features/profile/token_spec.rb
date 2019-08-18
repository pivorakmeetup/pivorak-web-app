# frozen_string_literal: true

RSpec.describe 'Profle TOKEN' do
  context 'when user is not logged in' do
    before do
      visit '/profile/token'
    end

    it 'responds with redirect' do
      expect(page).to have_current_path '/users/sign_in'
    end
  end

  context 'when user is logged in' do
    let(:user) { create(:user, :tester) }

    before do
      assume_logged_in(user)
      visit '/profile/token'
    end

    let(:expected_token) do
      payload = { user_id: user.id, exp: 12.hours.from_now.to_i }
      JWT.encode payload, Rails.application.secrets.secret_key_base
    end

    it { expect(page).to have_content expected_token }
  end
end
