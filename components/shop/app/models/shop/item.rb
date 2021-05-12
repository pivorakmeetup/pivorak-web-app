# frozen_string_literal: true

module Shop
  class Item < ApplicationRecord
    self.table_name = 'shop_items'

    validation :name,          presence: true
    validation :price,         presence: true
    validation :available_qty, presence: true
  end
end
