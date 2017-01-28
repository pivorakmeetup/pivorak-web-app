require 'stripe_mock'

RSpec.describe 'Donate Process' do
  let!(:goal) { create(:goal, title: 'Main Goal') }

  before do
    StripeMock.start
    visit '/donate'
  end

  after { StripeMock.stop }

  context 'invalid input' do
    it 'displays error message' do
      click_button 'Donate'

      expect(page).to have_selector '.error'
    end
  end

  context 'valid input' do
    let(:params) { build(:valid_credit_card).merge(amount: 1000) }

    it 'performs a donation' do
      params.each { |k, v| fill_in k.to_s.humanize, with: v }
      click_button 'Donate'

      expect(page).to have_content 'Thank you, your donation has been accepted'
      expect(page).to have_selector '.notice'
    end
  end
end
