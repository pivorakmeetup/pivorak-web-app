# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shop Cart list' do
  let!(:active_item) { create(:item, published: true) }
  let!(:order)       { create(:order) }
  let!(:order_item)  { create(:order_item, order: order, item: active_item) }

  # scenario 'display items' do
  #   session[:order_id] = order.id
  #   visit shop_order_items_path

  #   expect(page).to have_content active_item.name
  # end

  scenario 'display empty cart' do
    visit shop_order_items_path

    expect(page).not_to have_content active_item.name
  end
end
