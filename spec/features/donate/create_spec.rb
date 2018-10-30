RSpec.describe 'Create Donation' do
  subject { page }

  before { visit donate_path }

  context 'when terms of use are accepted' do
    it 'toggles submit and payment button when checkbox is clicked' do
      expect(page).to have_selector('.js-donate-form-payment-btn', visible: true)
      expect(page).to have_selector('.js-donate-form-validation-btn', visible: false)

      check 'donate_form_agree_to_terms_of_use'

      expect(page).to have_selector('.js-donate-form-payment-btn', visible: false)
      expect(page).to have_selector('.js-donate-form-validation-btn', visible: true)
    end
  end

  context 'when terms of use not accepted' do
    it 'does not proceed with payment' do
      click_button I18n.t('pages.donate.submit_btn', locale: :ua)

      expect(page).to have_content I18n.t('pages.donate.failure', locale: :ua)
    end
  end
end
