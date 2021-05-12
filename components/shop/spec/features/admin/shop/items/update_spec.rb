# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shop Item UPDATE' do
  let!(:shop_item) { create(:item, published: true) }
  let(:edit_shop_item_path) { '/admin/shop/items/1/edit' }

  before { visit edit_shop_item_path }

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Name', with: ''
      click_button 'Update Item'

      expect_an_error item_name: :blank
    end
  end

  context 'valid input' do
    it 'update season' do
      fill_in 'Name', with: 'Best Socks'
      click_button 'Update Item'

      expect(page).to have_current_path '/admin/shop/items'
      expect(page).to have_content 'Best Socks'
    end
  end
end
