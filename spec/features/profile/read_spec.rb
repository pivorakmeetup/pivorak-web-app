# frozen_string_literal: true

RSpec.describe 'Profle READ' do
  context 'when user is not logged in' do
    before do
      visit '/profile/edit'
    end

    it 'responds with redirect' do
      expect(page).to have_current_path '/users/sign_in'
    end
  end

  context 'when user is logged in' do
    let(:user) { create(:user, :tester) }

    before do
      assume_logged_in(user)
      visit '/profile'
    end

    it { expect(page).to have_content 'Tester User' }
    it { expect(page).to have_link 'Edit Profile' }

    it 'redirect to edit path when click Edit' do
      click_link 'Edit Profile'
      expect(page).to have_current_path '/profile/edit'
    end
  end
end
