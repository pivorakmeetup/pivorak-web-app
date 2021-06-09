# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/shop' do
  let!(:active_item) { create(:item, published: true) }

  scenario 'display items' do
    visit shop_items_path

    click_button 'Add to cart'

    expect(page).to have_current_path '/shop/items'
    # expect(page).to have_button('Added to the cart')
  end
end
