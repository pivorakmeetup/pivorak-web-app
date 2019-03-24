# frozen_string_literal: true

require 'stripe_mock'

RSpec.describe 'Goals DONATE' do
  let!(:goal) { create(:goal, title: 'Test Goal') }

  before do
    StripeMock.start
    visit '/goals/test-goal'
  end

  after { StripeMock.stop }

  context 'valid input' do
    let(:params) { build(:valid_credit_card).merge(amount: 1000) }

    it 'performs a donation' do
      params.each { |k, v| fill_in k.to_s.humanize, with: v }
      click_button 'Donate'

      expect(page).to have_content 'Thank you, your donation has been accepted'
    end
  end
end
