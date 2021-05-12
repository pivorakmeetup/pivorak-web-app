# frozen_string_literal: true

module Shop
  class Item < ApplicationRecord
    self.table_name = 'shop_items'

    validates :name,          presence: true
    validates :price,         presence: true
    validates :available_qty, presence: true
  end
end
