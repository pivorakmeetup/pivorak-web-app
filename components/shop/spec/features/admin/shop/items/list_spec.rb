# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Shop Items LIST' do
  let!(:active_item) { create(:item, published: true) }

  scenario 'display items' do
    visit '/admin/shop/items'

    expect(page).to have_content active_item.name
  end
end
