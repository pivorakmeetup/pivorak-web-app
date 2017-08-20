require 'rails_helper'

RSpec.describe 'BB home' do
  before { assume_logged_in_user }

  context 'not member' do
    it 'allows makes knock-knock' do
      visit '/bb'

      expect(page).to have_content I18n.t('bb.home.you_are_not_member')
      expect(page).to have_link    I18n.t('bb.home.knock_knock')

      click_link I18n.t('bb.home.knock_knock')

      expect(page).to have_current_path('/bb/knock/new')
    end
  end

  context 'already member' do
    let!(:member) { create :member, user: current_user, status: :verified }

    it 'not allows makes knock-knock' do
      visit '/bb'

      expect(page).not_to have_content I18n.t('bb.home.you_are_not_member')
      expect(page).not_to have_link    I18n.t('bb.home.knock_knock')

      visit '/bb/knock/new'

      expect(page).to have_current_path('/bb')
    end
  end
end
