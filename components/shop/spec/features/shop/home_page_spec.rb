# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/shop' do
  context 'success' do
    let!(:item_a) { create(:item, published: true) }
    let!(:item_b) { create(:item, published: false) }

    scenario 'display items' do
      visit shop_items_path

      expect(page).to have_content item_a.name
      expect(page).to have_button('Add to cart')
    end
  end
end
