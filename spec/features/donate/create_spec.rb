# frozen_string_literal: true

RSpec.describe 'Create Donation' do
  pending 'Disabled because of tax thing'

  subject { page }

  before do
    visit donate_path
  end

  context 'when terms of use are accepted' do
    xit 'toggles submit and payment button when checkbox is clicked' do
      expect(page).to have_selector('.js-donate-form-payment-btn', visible: true)
      expect(page).to have_selector('.js-donate-form-validation-btn', visible: false)

      check 'donate_form_agree_to_terms_of_use'

      expect(page).to have_selector('.js-donate-form-payment-btn', visible: false)
      expect(page).to have_selector('.js-donate-form-validation-btn', visible: true)
    end
  end

  context 'when terms of use not accepted' do
    xit 'does not proceed with payment' do
      click_button I18n.t('pages.donate.submit_btn', locale: :ua)

      expect(page).to have_content I18n.t('pages.donate.failure', locale: :ua)
    end
  end
end
