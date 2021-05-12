# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shop Item CREATE' do
  let!(:shop_item) { create(:item, published: true) }
  let(:new_shop_item_path) { '/admin/shop/items/new' }

  before { visit new_shop_item_path }

  describe 'invalid input' do
    context 'name is not present' do
      it 'validates errors' do
        shop_item.name = ''

        expect(shop_item).not_to be_valid
      end
    end

    context 'price nil' do
      it 'validates errors' do
        shop_item.price = nil

        expect(shop_item).not_to be_valid
      end
    end

    context 'available_qty nil' do
      it 'validates errors' do
        shop_item.available_qty = nil

        expect(shop_item).not_to be_valid
      end
    end
  end

  context 'valid input' do
    it 'creates item' do
      fill_in 'Name', with: 'Pivorak Socks'
      fill_in 'Description', with: 'Very hard interview'
      fill_in 'Price', with: 5
      fill_in 'Available qty', with: 10
      check 'Published'
      click_button 'Create Item'

      expect(page).to have_current_path '/admin/shop/items'
      expect(page).to have_content 'Pivorak Socks'
    end
  end
end
